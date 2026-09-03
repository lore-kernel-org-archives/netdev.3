Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1E337F010;
	Thu,  3 Sep 2026 16:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788452581; cv=none; b=PBgAr+TXnXPyVOLz2/keaZ/zKN5mtbXkdhUZQboIMy6nMD1ZQPnSQX6lxQro8f/A6ULB3f1DxoEUQA2RmZx7gYPZidoDMa3znDzWIqPhtZwhGhBHzolmj7jyXb2XjhuiWpSxBE812UsUd17V/SHovtprHaqk45rBC0Qd3obba4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788452581; c=relaxed/simple;
	bh=phu32JUFTt3ICOhnu0d3tCvXTSCvduiOR7VBPKK84Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bPHDwWeCbj2XEeCMADcgRlLgCpJzhL65Vs5IV5fMiYHloGa+CaoWkKGctRdVMQTOagnr8zQ+lApONcCVWSapi1SUfAQS7hi/Tx8rR+wePp9ICfF+DnHL3bvDF+AQhLQisJi14y3PyXYFqW4dk3HVT/eeGYqWMQtfHSaYbLUYFgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQyNgcpR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQyNgcpR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10F11F000E9;
	Thu,  3 Sep 2026 16:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788452580;
	bh=s0DcUKFUcOr6NqPWhrDGwNQBuilFraFwRJOhT/ht8zI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GQyNgcpRMHyhbCyUEHHdUEVXnWk9e6neDfS7T2sV0c4aQfC8nVeaEUE0Pr08q9ZUT
	 5zSMJI2DN2j9fyW5rhrOnf8o2i8j+qbCB+ZoOpIeXjnsVLNbBPSpT4Zrgk5M1qdJI+
	 uBu+BzbDdtjPw1SeLE2Z4VO3hXF4oUklBILWHwMQPcDikNBtMQT4vVkS3C9B1CaHei
	 vSMNEnuvRdjGYr7z6wHoBr91yXgKUfxrKgDx6HUAAd4Ccc5Z7B+mBt74RexoQFlhB8
	 iCs4YLN7ePUsvVUk8j0b0jt0oAy8qnnd8yfNMAXMiGj83fSnGIEGxyrKMOADMX/JDZ
	 LW6WwMo6ilHNA==
Date: Thu, 3 Sep 2026 09:22:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: Matthieu Baerts <matttbe@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Hangbin Liu <liuhangbin@kylinos.cn>, Jay
 Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>, Jussi
 Maki <joamaki@gmail.com>, Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCH net v2] bonding: fix slave_cnt leak on XDP error paths
Message-ID: <20260903092258.67ea7b65@kernel.org>
In-Reply-To: <62271715-fbd6-4047-9b69-b2bda40db056@kernel.org>
References: <20260903-bond_slave_cnt-v2-1-02e27304ca36@kylinos.cn>
	<62271715-fbd6-4047-9b69-b2bda40db056@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Sep 2026 12:38:14 +0200 Matthieu Baerts wrote:
> On 03/09/2026 10:10, Hangbin Liu wrote:
> > From: Hangbin Liu <liuhangbin@kylinos.cn>
> > 
> > When bond_enslave() succeeds up to the XDP setup stage, slave_cnt is
> > already incremented. If XDP setup subsequently fails, the error paths
> > jump directly to err_sysfs_del, bypassing the slave_cnt decrement.
> > 
> > This causes slave_cnt to drift upward on each failed enslaving attempt,
> > which would lead to unbalanced traffic distribution with round-robin
> > mode.
> > 
> > Fix it by moving the slave_cnt increasement after XDP setup.  
> Thank you for the fix, but it looks like it causes multiple KASAN
> issues, see:
> 
>  - https://netdev.bots.linux.dev/flakes.html?ld-remote=virt-bonding-dbg

Hangbin, this is at least the 3rd time in a week when kernel selftests
find issues in patches you posted. It's really time for you to run
these tests locally.
