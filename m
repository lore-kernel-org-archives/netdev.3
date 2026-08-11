Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025F02E040D;
	Tue, 11 Aug 2026 23:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786490460; cv=none; b=LSaMKya233pz/bHhrPppFo9fMI86feBKFFXi16zQwL4rQQG0BuWkTEWQqJNE/1phAYhUEuCY8/XsYL2Bz1TaIQqSvyHHQnBEqcbmTzGs8sAtAopL8K1T1XbEzW0zO3X9flW4qL2RBuuMgE4eDJ0ZSqPUdJhpul+dKpUZ0UZhM9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786490460; c=relaxed/simple;
	bh=hEs8COWMSuRnUUPfFUVg+5w6iaHO0TY/6acdEDItAio=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EFA+mw3q4yoanfOBKTHEi7zT440Q9g+4LscpqvIkF/URxpx/ie5qopYIjuHQX878BLKMPwWcflrGSqSi2GfF1ceQ+UMDURPR1vO4pc9H9t76F5Y7cKALNOUTm3FeFRHg6MxJdrcZMQU87lpq+HAehtEnxEyPGDzb7ygRhRzoRZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QI2Q94+3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QI2Q94+3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6158E1F000E9;
	Tue, 11 Aug 2026 23:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786490459;
	bh=hEs8COWMSuRnUUPfFUVg+5w6iaHO0TY/6acdEDItAio=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QI2Q94+3WfKa5ySbQAZ2izbaZ3DxJ0OIt5bxLCOUH3OOg76NaLncc77BHRz2y9gDC
	 OUuCXA45jOhqh7PO6mNuLdFXrrem0pdFDQtniIdMBOYK5geUtx5BcMMWiIcT85HjUh
	 ilCi9g+A47DZucMEfNnhdqhTeZliIo4hkZTFplhjqWmReRCIIkOhtJBMxDSQdAMRFC
	 pNGF4tVK82c4AYYlBiaGNdPbj79wuqlE4t3+wE9Kf/yveBaHX50Ut27drkxuyJaz5V
	 I0b7TGhhtLCPKlH8dDcP/59GGOjppmVt3ipsQJ63DRDuwa0JqM83XHs5YViMDE/mRw
	 5UKWCUBctmeug==
Date: Tue, 11 Aug 2026 16:20:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: natsemi: ns83820: Fix use-after-free in
 ns83820_remove_one due to race condition
Message-ID: <20260811162058.2662e468@kernel.org>
In-Reply-To: <da666a865879cf17574fb724242c742d081c4a3b.1786416553.git.xiaopei01@kylinos.cn>
References: <da666a865879cf17574fb724242c742d081c4a3b.1786416553.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Aug 2026 10:51:47 +0800 Pei Xiao wrote:
> Subject: [PATCH v2] net: natsemi: ns83820: Fix use-after-free in ns83820_remove_one due to race condition

Please stop sending those pointless fixes to long unused drivers.
