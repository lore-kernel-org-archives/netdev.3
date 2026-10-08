Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F59F204C31
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 20:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791489859; cv=none; b=Ss/Wu1tNgdbt4vEgNeBLUPpInhwgWOIPt7h64HQ2aYEeyOiTD0M7f4VO+kS3qMwkMlGMX2Ds+Q4n9Tk8TldNKsTd3XYeWgNPqS7H3POC7wsqZGWOwWkCbiw2WGchn30tyqYGmkmpIPFsZSU2XFoCr624Danx+kYERyu7o6BNVng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791489859; c=relaxed/simple;
	bh=F8CqbwTHoHgm12PJoNzhNGXIopUNfIFq6/dL7SAV0f4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=jBlHk4+AxopYljUCOn1Wb1wzwGKjDhdi8OEIQzafIosg5gUTB0bZyjcXO/AYfALe7AKq5m6oFEivsftEzlBoPMVGI8u1bRE5fbEoq9cUD6CMO6KcD+xZbMb25JTQTSeLQTTZqNANK15QgP+DOErx+iuLI9UCb/pOVOmnLaqTbV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvPH58rc; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvPH58rc"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6714595153cso998108d50.0
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 13:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791489857; x=1792094657; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2YzNoUbrYduJ7gMJ5zej9CY6dmwvGZhQGWMXIuJPX0c=;
        b=IvPH58rcMKMdp4cHenQddX4iQ+c5AXUC64feyuf+WA+KHm6XwiJabY7RPC+jm72are
         JTwYfMNN3FuHVkYfYaG940XWV03kSCJp7wHSGrgti5Ht+CZXM4lR88X5Z4c6WS2aUa6i
         Kpt5uzea+4rUN3DhmP0zzDZEvR5kribn1wkg8Of9bTBXxUVuZJKjWHQUukN77HFWbyNN
         JSl66KcaFvbFFbUnOhxBvkWOlN0FlJWa28S7KJ6dmSByUX3v1Sr16arf9gtT/ip6uUDx
         n/rlwGvSN/7gpYn2aqpoXhrUJF94N6nNJvbEcViwsL/saP9Yvti1i/LQQTuy50Q03K55
         SQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791489857; x=1792094657;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2YzNoUbrYduJ7gMJ5zej9CY6dmwvGZhQGWMXIuJPX0c=;
        b=wH2RYCKWlR5h+57LIDdAzoBeXTQyvm6QpZS8pp9JDl7R2x6P97qYMVa/PaQDlhp311
         UIKkq4TmHyQ33w6Q9JRiV8XmsIOvR9HFPvx91621lWW6J6nmGfVO5/7mEzfVqcbpkTJQ
         ivwshUIFnWdy2AJunQImlHrBkfnpWGU6+FIho8MCssz2OM3hMFeLRQ8xjLj+qCKZFdaC
         +w3EijT6Pau5kfaYf4qifb10tM9E3lP4yp1t9V878R04oIdbX0W32r/1r7K90WT4Vqxg
         iewltrMPa53OuV0rDAH2xLHtdnPXebuobFc3JOHyVVFPBGqgOIY+kHSWCG1uGOhtE0B+
         5f+g==
X-Gm-Message-State: AFq9FYKHMQ8SOMybxGQAHOi6T+s+1EjUbiA5HYLyoMngqI+5G5O/nHTx
	Eg/Ki7/2tjrvL7jex9AwgQ3w0KrepB5DKq8dEWLZwb19LjDIAzPQwVQC
X-Gm-Gg: AYBFou30DFpbDcq3tGPo5pMbZoseYEte5Dk58xhXZ1BMd3xxxL0kTEPuBoPvRSvKgHL
	fVYqG/CPVSHbxKyyD+Nl13qYFrd561hg9wmMRDZDzZWnrDe6WwauvUjslXdP09+iKEEJ4o3frkP
	ExjxQt5zjFEY2+8Uw44cDv2kquV8zYTIhAE35n7Tjdt2IzJqxbUnVYpObPuxjkEh8Zb9WBV/yoK
	5MBgSPr/Rut/kG152Wk1fdOXN4iWY26WS+uDsvvAEq222dBO2lMZEECTJEFDq/67zcp8RCMaIYw
	aQkKKwWwDfVlsFiaaHeO3w53nLBk03GPR8aoIXKwpvDGK/H3ZlGxUNtPnlEI9xL7/rk/NAMpasv
	Z9bSVaMA0ZYHXwGy/k5IXTCiGmi6gJusDc17Avx67tHWHjJu7VbZm4AQxxlChLlsa6MXvnai4jx
	23E4f25boBhLLM/dMGtJfTbIsdTSY1Z6eIF55w7WVAHAES/OWo+t1GEWaACcQ00QW1GBZm5BbpH
	xoAk0FHtbBkBlOytk0Y2hVkLW+OM7HaabvHCbN5U2Q9Fyx9ey7mgKET6QIz2a0F/vMrcYT3Tk1I
	5LdxcmCJilFhQj8QN3BsiunX+kvstTL6QiaqRA==
X-Received: by 2002:a05:690e:124d:b0:677:c5b9:8f2e with SMTP id 956f58d0204a3-67923217533mr1215806d50.35.1791489857324;
        Thu, 08 Oct 2026 13:04:17 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-679356a9402sm38162d50.14.2026.10.08.13.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 13:04:16 -0700 (PDT)
Date: Thu, 08 Oct 2026 16:04:16 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev-bot+sashiko@kernel.org, 
 willemdebruijn.kernel@gmail.com
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 andrew+netdev@lunn.ch, 
 mst@redhat.com, 
 jasowangio@gmail.com, 
 willemb@google.com, 
 habte.yibelo@gmail.com
Message-ID: <willemdebruijn.kernel.18efe47d2170f@gmail.com>
In-Reply-To: <179148831819.434549.14553358529954439471@kernel.org>
References: <20261007163819.3041710-1-willemdebruijn.kernel@gmail.com>
 <179148831819.434549.14553358529954439471@kernel.org>
Subject: Re: [PATCH net] net: extend virtio_net_hdr csum_start checks to VLAN,
 IPv6 and IP options
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

netdev-bot+sashiko@ wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
> =

> Critical: 0 =C2=B7 High: 2 =C2=B7 Medium: 1 =C2=B7 Low: 0 (1)
> =

> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchw=
ork
> know by including "pw-bot: cr" as a separate line at the end of your re=
ply
> (one such reply per series is enough).
> =

> - [High] The fix leaves the UDP-tunnel path, virtio_net_hdr_tnl_to_skb(=
)
>   in include/linux/virtio_net.h, with the same weakness it removes from=
=E2=80=A6
> - [High] virtio_net_hdr_thoff_valid() decides whether skb->data starts
>   with an Ethernet header only from `skb->dev->type =3D=3D ARPHRD_ETHER=
`=E2=80=A6
> - [Medium] On the non-ARPHRD_ETHER branch, virtio_net_hdr_thoff_valid()=

>   leaves proto =3D 0 and then guesses the L3 protocol from the version=E2=
=80=A6

All comments look valid and require a respin. Any revision will take
them into account.

Based also on the previous conversation in this thread, will review the
approach. Updated in patchwork to changes requested. =
