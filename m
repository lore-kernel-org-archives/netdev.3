Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38CA3876B2
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 22:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791410846; cv=none; b=Zrvjm5sFiiraQ2jMqZvSS23EH/oJeWzpxTNkfGGbxgwdEWH7eexnQAWvlu9JNBrflBD2vds2J24hR1c4Nq/SqS0FeBl3hCrPuQjKUj53gKcWQ1vv8YupTMqez49f9EPTi59sX2EDSa5GUWJnBI5FEDJ/9WUtBLE73SCt6e0GSfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791410846; c=relaxed/simple;
	bh=pzcU6DRrnPP2DBnNwpaFuVjPLcGW2IMFoch8YJke0x0=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=ILf2xbdlOr7rB9FDTbeGNP5mpyhSdsW2bZWU/R2CiEpw1/XAwSkPL1lnrii0E5m4kAh/MT5ni1CAt3JadPr54sc7/eBR0tZPgmaFB6wo2HVrr0grCuwjRhX15DYuTK1bvKY1bRgGGtI45Qa2jZJ8Ban28ieeBASGxTQABxX0S70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9gJXs5a; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9gJXs5a"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-504db7f7870so124062b6e.1
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 15:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791410843; x=1792015643; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :content-type:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pzcU6DRrnPP2DBnNwpaFuVjPLcGW2IMFoch8YJke0x0=;
        b=H9gJXs5aH9Wo/P+l3arURBaEdRI4vPCaQ93ookE/1r3Ry4p8jpd1JSlyerzemDLfV6
         AIfOtT9mOiAqdhQFppi3VNBXO822dsZhX3IBf999B7/Pd/BBudTXopEpdJJs1Q8mjcZ2
         GqKnoZnbzSIo4Gg/APR2y6V8mGfwh2Lty4eZRu4ZW9FULxSPeVHvokI4h18PuIdTSTrt
         bWO8AH7cJHd+mb7CwA9IYsA4vfZqmT2XlLOEVn7M9guUfm1RjcXvvccSOC7HnYSYncDP
         ZyuBrSUYze/99DVxejyhGDR7Si3mVeCwsc+yGeEA1NfRSS0c5BP3V9AN/KvkDJSk8RRK
         oguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791410843; x=1792015643;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :content-type:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pzcU6DRrnPP2DBnNwpaFuVjPLcGW2IMFoch8YJke0x0=;
        b=k4JJinMlC1inTOgFX/b4wGQuWVR+rFFZCWVXNtVeWCfinozzQhlGXeVOFG96blhNXL
         ZooMhDwgpfaMqqe+sWN4Bsl66EXbgJcBObv4oMPevpXUA2UDszxhOdA5rSx7KGv7C46t
         65jZGm3ceOZY1yG1fZUFR3i+vL6y5xYV5AYGgoWifbB57HOFKi8mTXNHr+jDRrSJVWg1
         AwGqs8NCKqqcfyZVHKpW8Zp3yXZrQlSWuJSTsruIGzJHT2Broq90Mq3DtjHBvtKOvgrE
         /dH+MUFRB7qboZ4u85tBeLXJ321Lgd3o6v/ElpwbqZTRzQMLVAcVxNbcZy66xe4YHRuN
         kDvw==
X-Gm-Message-State: AFuF++nn+bUf4hugVtUiOm9Iz4hTdltdQq062ZSoRfK5Y8lbOdCrdVNz
	72ZGFgY5LgAayhy6T2EjsPEQRuKz/SLd30CK99a+nZnek6JBZShqT2B/Jfe4+XJX
X-Gm-Gg: AYBFou1VcaZAFfTEFu3j9NlxtSk62Kx32RxBM5Sf5lq8i3iWFWSh3l7Q0lfCVumFunh
	sfQKBuhqUo+1KQX7vtPQLrUGRjezvyegtwuaRYb11Ai57Sjm5VfzlY3hTPoqprxh/97q7Btqiak
	9+ZAtWqu0kXTNJrqWQQ83jebWZWFT1IOpJAQx+WC22C2MrupsyvJlObTTrZsdPmHqYOK8DrBhsK
	2afvuvVnkeutPNYm3izWUXyZMJYwLYas17hjzSNl34g+YVca5Es6+PG6dwCODHlbYTJIiilJXk9
	lXiBZgif+FO4SV8bh2Kovc9tKBjGJjnpFgUqY8WKuWxn/HpGRi1G81LxH/8SI9dk61Kuih4Gj0+
	KB5eCOWLNtrxBMqr+daKg39/xiH+8T02SqbgMeVeb4C6MEmLDY2atypmREWV/Z9x5cPlas8uy6X
	pYbFMjyTglnJ8CjpzmRiLDg/fvzSFZYBwmeVXdD5qi0eoNEctYZL0GuRmS4zlWnI0eN1Pym12pW
	mhBMLeAzbnJ9Qy72mQwg1WNuxU=
X-Received: by 2002:a05:6808:1585:b0:4f8:4a95:9b3b with SMTP id 5614622812f47-4fc481c5f12mr3624420b6e.68.1791410843223;
        Wed, 07 Oct 2026 15:07:23 -0700 (PDT)
Received: from smtpclient.apple ([2600:1700:220:4650:f501:3b3:565b:2d79])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4fc431ede8fsm3802983b6e.0.2026.10.07.15.07.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Oct 2026 15:07:22 -0700 (PDT)
From: Azadeh Aftahi <aftahi334@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: [RFC] virtio-net: AF_XDP zero-copy TX checksum offload
Message-Id: <247B8E70-8100-419A-95C4-71E43361FF73@gmail.com>
Date: Wed, 7 Oct 2026 17:07:12 -0500
To: netdev@vger.kernel.org,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org
X-Mailer: Apple Mail (2.3864.700.51.1.1)

Hi all,

I'm planning to work on single-buffer AF_XDP zero-copy TX checksum =
offload for virtio-net.

Current net-next's virtnet_xsk_xmit_one() does not consume XSK TX =
checksum metadata and uses the shared zeroed virtio header.

I found Xuan's 2021 proposal anticipating separate headers for checksum =
support, and the merged 2024 zero-copy TX series,=20
but I couldn't find a checksum-specific follow-up implementation.

The proposed scope is to map the existing XSK checksum metadata API to =
VIRTIO_NET_F_CSUM,=20
using a DMA-safe per-packet virtio header whose lifetime extends until =
TX completion, with corresponding completion, reset, and unbind cleanup.

I would keep the initial scope limited to single-buffer TX: no =
multi-buffer RX, timestamps, launch time, or GSO.

I'd also add checksum and header-lifetime coverage using the existing =
XSK selftest framework with QEMU/TAP.

Is anyone already working on this? If not, does this scope and =
per-packet-header approach sound reasonable for a follow-up patch?

Thanks,
Azadeh=
