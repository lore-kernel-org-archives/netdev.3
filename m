Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DA12741C9;
	Sat,  7 Mar 2026 01:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772846317; cv=none; b=ebTtFRdQujsLzGCrtz9Jzhj8jJScBzuF/X9jW6U9Kh2UriOP+fC87kJzrCxACnwVs8biLHnFR22hUF3qdpuCw8/ar0nSdMrfXvqHwek7orjA41eYEKf/i/SF3wBnqDtiKKRgodY6sp1n5W/C2SNuDKMIHZ0jWOY4WBG2g3rx5lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772846317; c=relaxed/simple;
	bh=8DANmP9ZriDggBHNReYPbVp2sv7HGDkhnwp/ZvE0M0s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PsesocP0sK35RKJK8snXbY1a66457C9QwYHqonL+t3324XkbusPR+TBWM6zUytU+rzNCWXY24jPDgiFalJ1aFQfvChAZ2xrJyiCdBNxQbzn/O8hnq543IxTWvOqJpBNZZOLd6n16ydj0zWEpyT01BlJsFLpICY1LVL8oiMJ/yqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxpmuuDT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxpmuuDT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2185C4CEF7;
	Sat,  7 Mar 2026 01:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772846317;
	bh=8DANmP9ZriDggBHNReYPbVp2sv7HGDkhnwp/ZvE0M0s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JxpmuuDTru0fjnnDF18KFx68/rWH4D7dF4t4rPSzOaoJ6+i1Dj+yEhQtPmvKek8Bh
	 SICmIe9E8YmATh7oRmkqNAFB2m1X21i8fTAa2bPdkpVNxZQpWSJ/Fj6tmJeM1Xvmc/
	 XPqb+q6YscK0Z4WvE67KxEhU/CbyRV5TDIaHDOna5AGizY1DTm3QAok/+hSaJb0sVF
	 0IhJA7ZOOFKM50amkj6CiMJf5FsQphEXeAgamMNTvFMe2d7FkTeXNJR1VRTu9zu1Zk
	 J2m+onNYzjBlYHmhNtRoZ92FUQO2CvIlFvT0woEeTp/K2//HoeansMHKcHmEGNv4+W
	 7lpGP0aQ9PVsw==
Date: Fri, 6 Mar 2026 17:18:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Marcin Wojtas <marcin.s.wojtas@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next] net: mvneta: fix NVMEM mac address
Message-ID: <20260306171835.6512cb2b@kernel.org>
In-Reply-To: <20260305224643.14524-1-rosenp@gmail.com>
References: <20260305224643.14524-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  5 Mar 2026 14:46:43 -0800 Rosen Penev wrote:
> Subject: [PATCH net-next] net: mvneta: fix NVMEM mac address

When you repost please change the subject to

net: mvneta: support EPROBE_DEFER when reading MAC address
