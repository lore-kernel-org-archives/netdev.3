Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691C737267A
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 23:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788478381; cv=none; b=WJwkrZgXgR6ha+4834L4KipD8bb0rU2byI8rwbJg3w0F0DTw6aXh97G0ZY1i8q3ZLHcJhNIRcQ0NFF2bm2FgCBEaB1qhG6ugLHs+19c+PjKGluCldvotunzIx1zxsiQbOttXxJZik67teNal36Ly8+gNJ8QEvwIwURwt1fMqBwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788478381; c=relaxed/simple;
	bh=ziAYVLtZ4TiQH6oOKLvQPis4VbaDXHVhrHIwnzmTLos=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition; b=NpgiKWGzYElzUw+J1VsxRCJ7+BGj3X7POnq2/+KnH8Jb4602JJ1kMSRT8Rv65vE6plljACXANdBcKkjLy+WUueEpsDkO7tJ1KkbIhmIDdrjxpdmK8ixdHLNe7soU1di/zoT9ZloLHA8cgU4DnCcwf5KE4lUN+OoUEtM4COrMHII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=GJU1xU+K; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="GJU1xU+K"
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-8556ec44e9aso342841b3a.3
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 16:32:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788478378; x=1789083178;
        h=user-agent:content-disposition:content-type:message-id:subject:cc
         :to:from:date:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m5t1mj/88os9E+H3rZjlGdKerbAWo4YdA8lRi9D7mYM=;
        b=BPV1gAExSEFoOwKgAw6CJBsjE+qCMmo5WaIBv463J4WlVs1ugdmd8fRKnmIaJOURIK
         lJXaarzaCoMauvsZ2AH/XPABIfN1TZKcSGMkV6DxdNaW9wPhxT19QhQOS3jF0udRx12h
         OnfgCxZEXarw6qV4DIGuo18U1DywRSaWiy+cLKAwGuJUwNx/eDNJKqlFJ7wbM8s/3Bco
         +YFT1rPhWdAuDVUVxQePd3xCZh2H2ip5TZsR4wBH0gvEBZrk5Q3B0tXjK+yXJoYQpcLU
         aZ0KbAyeg6+49+PBjewX0uSHdr3knsih7wVvbOAOlsb4A4RjbFL+tHvKGBBp8qWU3eON
         Q6bQ==
X-Gm-Message-State: AFuF++lH1U/T2E+DR+c8cXtjaFqfkxynG6/YCRlDdpr1h/xN3JUEYrxZ
	mqFtJyVxUtDEiXlzg/18dBlYiCDlV+7SGRsYcGPN/d8RAacXBG5MXoypwuDaGpzlz2fMaoAF1lw
	dlF6oWn7TFTxB74nvxgrSWA9LgU0kkm0Ung==
X-Gm-Gg: AYBFou0ul3DHWoeSOOMLTe7SWbmItzP5XDoXTI+X0Z+UI7WTeyfVhYibw3BVR+pJ+wd
	fHG3gqUjbw3Xoi2acvqwiNZdRqrZ15WqGM4zJqef5zVUqllnqNgdoDLvT1rLiTcqegre2q9BKGr
	/7EqlhhzsBZ53HpDd3wKNJsv/3bNekSwaP702HS6bYMMVm2uVE+BgEKIh+/NE4ir/9VCWlMrF/i
	zzAxB/M7p3MFYlDEMWGrUz/sg4Kgxq7Kf1LVi3xOU15dk3Yk1BGL1Gi7314nLkpHTMwJlOsa3Xh
	SMkjF646HSgsSU4OTgJVy87MPr5vM1xREXUox7pTNOzAKjNB2GL+qzI1lVYEbV2U5TvzpVnTZa6
	j517WwIiouaTJV86glVq1y/Jb7jbPrtA=
X-Received: by 2002:a05:6a20:4393:b0:3d3:af66:9f61 with SMTP id adf61e73a8af0-3da3a16b389mr2923695637.27.1788478378499;
        Thu, 03 Sep 2026 16:32:58 -0700 (PDT)
Received: from smtp.aristanetworks.com (mx1.aristanetworks.com. [74.123.28.25])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cc4553f38b0sm127778a12.5.2026.09.03.16.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 16:32:58 -0700 (PDT)
X-Relaying-Domain: arista.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1788478377;
	bh=m5t1mj/88os9E+H3rZjlGdKerbAWo4YdA8lRi9D7mYM=;
	h=Date:From:To:Cc:Subject:From;
	b=GJU1xU+K/YA524nFU54iyDXiY6R8A7DOmS0O7ESGF48MK7yjmCXkKTv94NOzKVrpX
	 M9EtKYi8iDBWkcNLe6bE/ivoEl4liyYwyl+QLWahwKfd2umMm9slZuFJ+C29aWVXIQ
	 AdEqsx0TKFskEap1lYg7voDeyHi8EjQeKak4cZsh5HaTU7VD1KF8OOF3m3oyUxvSp8
	 OeaW0Kr0qlRgWV07wrraFTAzLPbGu3LpBq9Z8aot2hqGOS7Y5JDwkblU325M3a6BhL
	 FbHq/h5cPlb8g5MHsXj9/H8pDVVH/j7uNiANSttY8id6jsbPj0X68t91KYb6i8h8pV
	 g5YomcZhNF+Fg==
Received: from visor (unknown [10.95.70.246])
	by smtp.aristanetworks.com (Postfix) with ESMTPS id 60087100819;
	Thu,  3 Sep 2026 23:32:57 +0000 (UTC)
Date: Thu, 3 Sep 2026 16:32:55 -0700
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
From: Ivan Delalande <colona@arista.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: netdev@vger.kernel.org, Paul SAGE <paul.sage@42.fr>,
	Vincent MORVAN <vinc@42.fr>,
	Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Subject: [PATCH net] tg3: check NVRAM and control register if SRAM has the
 placeholder MAC address
Message-ID: <20260903233255.GA4109366@visor>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.2.12 (2023-09-09)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Some of the tg3 NICs we use (BCM57762) reset the SRAM MAC address to the
placeholder address on link flaps, tg3_chip_reset, etc. We've typically
fixed it from userspace, but since e4c00ba7274b ("tg3: replace
placeholder MAC address with device property") was merged, tg3 just
fails probe as we don't have a way to get it through the generic
device_get_mac_address infrastructure on our systems.

Since that commit effectively made the placeholder address invalid,
include this check in the earlier `addr_ok` expression, so we proceed
with the NVRAM and control register fallback to find a valid MAC.

Fixes: e4c00ba7274b ("tg3: replace placeholder MAC address with device property")
Signed-off-by: Ivan Delalande <colona@arista.com>
---
 drivers/net/ethernet/broadcom/tg3.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 73a4b569b03e..0b47908f0935 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -17081,7 +17081,8 @@ static int tg3_get_device_address(struct tg3 *tp, u8 *addr)
 		addr[5] = (lo >>  0) & 0xff;
 
 		/* Some old bootcode may report a 0 MAC address in SRAM */
-		addr_ok = is_valid_ether_addr(addr);
+		addr_ok = is_valid_ether_addr(addr) &&
+			  !tg3_is_default_mac_address(addr);
 	}
 	if (!addr_ok) {
 		__be32 be_hi, be_lo;
-- 
2.43.0
