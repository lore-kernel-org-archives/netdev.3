Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03BC46C849
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 21:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788472625; cv=none; b=ndsDxsGD60RlJocuMZfsZVp0zu87/M8ieNJ5YsuV/+3iEpdEcHcftUMfiC2qX1ozDFTaafsX0Q4cAbs2d5uUo4o5buK/qyaZAhjEGWuF5wTCW+1ileVmRuaLHpQx+PJExn2Ki4Iqo5tp4TULpOm2X9e5M1sEKsPE/AgZBDS6wzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788472625; c=relaxed/simple;
	bh=UUSqtnLWe5aZRYDj9K196OkIKDN+Zyhhau7+NTVDMnU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JyGC7ChWEMdq+aILy0TlvupzC4L+fmGLnUTnYQCgHQv2wsEZ1S9joXufgH4d7ppnhXHhLooG+mET3mRCeMXRKS3i0cOFSwFKBesgeEISWvAjMkyLCi+IMZ/0ApLX8BpKk9CEtpph54bPaOzhyqbJ5qileFA7u1Ge9WEcNzGhDOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=myUeuBjv; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="myUeuBjv"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cee1ec30f2so3864725ad.3
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 14:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788472622; x=1789077422; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qPa5Isz91A5PrjltfQrSDK6J910QYzqvDKsVi0XwhYs=;
        b=myUeuBjvcQSfd1cAX26zih9VQxvP5Btgl5CTlWVkjO3Zh5nkDO6Gj02kLpl2ImqB6o
         kKoo19Vj/yPSDrsccRdXEXDSGpumSsdCsHghbUCgoLnvfmDZd2VsOZEm2Z8hqoUGgHu3
         m/0OzdMhhv28tVFgtp/3I4B5+Te4xpnTPD9c/71WCst9BjZDO+hjEDMBy+2+EKyywqAR
         FqxCFwh+KowVJ/PbcIgDdWYxd1NzkEr8AOjMbll/wQblXHGiDn0AypsB0FMqXatn0MJ4
         +2dQuq8yKlhXgxM/9+Wy3o+ruyno96KEX6z3d2goYBNModehKYTxWIEI4jh29K4NbXPE
         tPrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788472622; x=1789077422;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qPa5Isz91A5PrjltfQrSDK6J910QYzqvDKsVi0XwhYs=;
        b=SRY+VN6MnEzO5YOhN+HOcTeQhTK3uWtHuNRVGPX2uo9lSl8qLDuW3vsQr2qWTKiRuB
         haYD+xaFERutbRc2W3vWa0fNBIOD1dFeest/AitwDszkkvjYLFnIZn/gjxfogbDLSkZw
         F35o/20lkOVOjPaswtK+Ts+4RtA3tPdGaoJTtHgTcJ6bhs9yh/CRffDpinaHZyXQYs30
         nFIGmUwFu6YEC/NrgzgRPjJS63HHatjm2ocl9vUsr5SKjYf5DjRx1CBiEXzbgxDm8J4I
         yQulHdRzgKoGC6OCIv7m3eBVHMxEp0odr+R8Ye87Gy8i8f5okZA3jYEq9ayUmBhM5h83
         TXjA==
X-Forwarded-Encrypted: i=1; AKwUvBwUOlqMIox0qShYnzS0a6e7NmH/kiS7VjQBlU0zSdAuSbrIC9NCwppy4WfFONFmd+sJET0I4Hg=@vger.kernel.org
X-Gm-Message-State: AFuF++mRaG8wPDgcf+z7jKCVKtYkVFhqH0grTEKYW1qddQKraqIH4A8L
	8BNgBOUR7hAzn0EBvQW6GxrEXv9JXOYcsEpcPjIzgRpj2mq2cCw38/DgJvE1mzOsMGOA+5WbYqB
	VUr8miQ==
X-Received: from plq5.prod.google.com ([2002:a17:903:2f85:b0:2ce:fc5f:e782])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1844:b0:2da:ef81:37e7
 with SMTP id d9443c01a7336-2db126b1bcfmr32446965ad.21.1788472622253; Thu, 03
 Sep 2026 14:57:02 -0700 (PDT)
Date: Thu,  3 Sep 2026 21:55:50 +0000
In-Reply-To: <5832ba17-c096-4f07-aa73-2e2bb6f79856@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <5832ba17-c096-4f07-aa73-2e2bb6f79856@redhat.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260903215701.2270160-1-kuniyu@google.com>
Subject: Re: [net,v3] udp: revalidate socket family before publishing an IPv6 cork
From: Kuniyuki Iwashima <kuniyu@google.com>
To: pabeni@redhat.com
Cc: 4ncienth@gmail.com, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, horms@kernel.org, idosch@nvidia.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev-bot+sashiko@kernel.org, 
	netdev@vger.kernel.org, vyasevic@redhat.com, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni@redhat.com>
Date: Thu, 3 Sep 2026 15:22:57 +0200
> On 9/3/26 3:05 PM, netdev-bot+sashiko@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 2 potential
> > issue(s) to consider:
> >=20
> > Critical: 0 =C2=B7 High: 2 =C2=B7 Medium: 0 =C2=B7 Low: 0
> >=20
> > - [High] Incomplete fix: the sibling IPv6 socket-dst publisher in the
> >   connect() path is not covered, so an IPv6 dst can still be installed=
=E2=80=A6
> > - [High] The fix is writer-side and after-the-fact, so the mixed-family
> >   socket dst it claims to eliminate remains observable by the unguarded=
=E2=80=A6
>=20
> It looks like fixing this kind of issues, if possible at all, would
> require adding a significant complexity to the data-path.
>=20
> I'm wondering if we could just remove setsockopt(IPV6_ADDRFORM) support?

+1.

The feature was initially defined in RFC 2133 in 1997, but only
two years later, it was removed from RFC 2553 in 1999.

It's 2026 now, and I think most (all?) applications are ready to
be passed IPv6 socekt fd given systemd does not use IPV6_ADDRFORM.
