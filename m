Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1124E73BA
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 17:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789664925; cv=none; b=FCY0pVf59JrOrnEBQLulGHxrXZ5l44LZRjIhhZ3fsMmW5ukeEoLDxrg/Ab3NQFqTNMdlbE1Izc1rS/S22S2JhUwUuZhewwB5e19edDAsBs4dye4VO8tIEx/nthiy4N2pDbIncTtx5keKMQbWe6a2PR0V1+rURa44+QS2g5dRpCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789664925; c=relaxed/simple;
	bh=ezE7e+8hPeD6bknEPOWbSDt55vcUmx1NSW5YZif6bkw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DEGs1L5kdotfDzxGPiOZPRFOQSa4NOPE+ZnmWf6BNsA+wREqXDLjRVNu+U8Gk8lds4qjXUAo7u2h/vNyQ2UgV25+p5qiVoF9ke/fcIxPfK3W3f0jE/w2AvSJypojvj3YhDNsGbWuwTeXaziZlwYqiH9jw98/h8fvuDNAl71UhPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iVuYxTvN; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVuYxTvN"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd78e6eso375622a91.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 10:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789664923; x=1790269723; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ezE7e+8hPeD6bknEPOWbSDt55vcUmx1NSW5YZif6bkw=;
        b=iVuYxTvNLMPjMAfCW0j0FNuCl+bP66PzxM1D8pkhlu1zOCzoAwveE2Us06+t+lejrl
         U5wg8NxNiGf5QlOwIvTLXv4a//VHwxWfxCPhiurnZ6vBmPdvfMolH/PWDtbF6TCJOqi2
         44aZWQNYE/YrlW0rq8dbgX56SbYAhFCMahUnZgXl5dDLyP0S7zRojFPDP2BWMT56Upcl
         YRSacQvl3TzEjo1yPvbd1YveNaDKieB3p9GI/forJur2LMwo/Smr8Ax3uI3qEzEAJ21G
         D4BbKbFsLiln5668FLJwWTT34JuzyB5fIMmqZ/Zb6ytdtm6D6HRIxzchRqxnwoQFLUwD
         6jWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789664923; x=1790269723;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ezE7e+8hPeD6bknEPOWbSDt55vcUmx1NSW5YZif6bkw=;
        b=fEQI3aB4XQj9B9c6XLAfvndy5m+p0S4XLwzxtLMnSnfBcjN7FRtRP+43vizK9cLon/
         u88iS3wHa0TVk97x3DNeBho9y9HTbp3g1fM6yBi/QPv2zEUrok24W84V97K4kiOJXTVe
         KdxvC8LtxeaiA305EPEu4XBQigg0HTIX0ObM/pbq6IdftPsKXQGKOlSJ3yqO5AfX0PPF
         353j6uxSLNYAcGT4XhS7wf7GFX0yvwUbbWZ70u0NKfGCr069Ed6mD5/4+yqmuMlUrcnz
         RrSv+efFv8lDdlOUipwNbEela/SPh8s3v8n2C+knBhPUFLRTe7TRyZ8I5j4hZMcuWcQk
         nBvw==
X-Forwarded-Encrypted: i=1; AKwUvByQ6pcP8TcSH8jzPNAsmyaiSA6yKZdeRVMjzxDtqvT4Co5m3l8VFygJ7Mpv8/n5dnct2GhCNgE=@vger.kernel.org
X-Gm-Message-State: AFuF++liWY+KgiZN19wtiJ+5rw0BZ3Dp6bBeTIow4/kCa6tjqQNDyM2u
	WBAyxCA68WlFsBvtR+ve7pAfVLSfJ4uZcwa+kTiffqIppf9PLVcgk7Kd
X-Gm-Gg: AYBFou2IVXMMbUiOIrutOYlRTuOmM2qDzJeiOtMxJC3+AccEzMGfleH6dYW8aAyWVEw
	yAL3NU5whNbthi3YiX6whoXkh85sYOad4/BG/nSjZlothkRdJaAxe6WnIn5/oGYAgd6fgfT33zK
	qP2I/lKLzxHYC1wNVvHJ47ADoEwPYCKwVaKIPxyj0z1SKW42Oom1KEYvCksWcjWN8kpIcCyXvGl
	/gNu9QpUqPhAlIowgxGc0hERUQoJZxF46LvIFdnjQl5I7IX3RNPpXPtGTvR3fx26Vv5N/OrGhpd
	HPcyWU7f5tQYfU4ePzZk3S2SsgdjPRdIYfIQLocVCig+gasbk6qRaCHseIEI/CMLwX7qFEY0nt6
	/Kj8ZgnsZoqkhxT+d9G3cYQ+fydspIqI7utq/E6l33pazqnuzqxfHDUSIFi01YzEczunwXy0+cP
	JtCWvqZAPN4hoSgBgTomkrO0PUCCTwW8yMsnbylM0RSYO3L+XCI19XokC5O5K6YoDOuxo5eI6hw
	TbPe8D+pzwPXMIu5UYXRMomzWlG
X-Received: by 2002:a17:90b:2c87:b0:39e:4c7e:bc6 with SMTP id 98e67ed59e1d1-39e4c7e0e37mr1026900a91.20.1789664922555;
        Thu, 17 Sep 2026 10:08:42 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e361b7266sm6066044a91.13.2026.09.17.10.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 10:08:42 -0700 (PDT)
Message-ID: <c80c4e2aee9502d781fb52bcd5c0972ccd3bc7e4.camel@gmail.com>
Subject: Re: Missing signoff in the bpf tree
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mark Brown <broonie@kernel.org>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, bpf
 <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, 
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Date: Thu, 17 Sep 2026 10:08:38 -0700
In-Reply-To: <9d668d7c-8f85-49ad-bdb9-5cb81fb6f60d@sirena.org.uk>
References: <aqvBPVcN__UX8P85@sirena.org.uk>
	 <DLHJEZ0K0FV1.SCQLJJQNS1ES@gmail.com>
	 <66d3f5cd-12df-4000-8459-360ba57cea12@sirena.org.uk>
	 <DLHJUSTDSQ05.28VUGOV7YPS6V@gmail.com>
	 <ec2acd16-40e3-46b7-b120-ce9eec70e942@sirena.org.uk>
	 <DLHK013DCY3J.19Y8X3Z0RTWCI@gmail.com>
	 <9d668d7c-8f85-49ad-bdb9-5cb81fb6f60d@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-09-17 at 16:03 +0100, Mark Brown wrote:
> On Thu, Sep 17, 2026 at 01:27:01PM +0200, Kumar Kartikeya Dwivedi wrote:
> > On Thu Sep 17, 2026 at 1:23 PM CEST, Mark Brown wrote:
>=20
> > > Do you have a full list of the current committers, I guess there's be=
en
> > > more bitrot than just this?
>=20
> > It's me and Eduard, apart from Alexei, Daniel, and Andrii.
>=20
> I've added you and Eduard.

Apologies, that's on me, some issue with scripts configuration again.
What would you like me to do? Force push with SOBs?
