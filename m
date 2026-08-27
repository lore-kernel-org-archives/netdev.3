Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3381844E671
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 18:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787855911; cv=none; b=XXfac9f1aFQG+7+QbAWVnjzmAyKy1cO6uYYISHxMlr1kiwGnm0lNXbEomPhp1kbyZyNG0XjOxqBFwrRWZ9Z2FT8Y4E+hBO7p2J+xYTyFwmmeAvTehK49+w8bNq6YLFeZvvuLlqaSYgQcOPZsj/y53DIswIDV7/LImqwF5wSbFXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787855911; c=relaxed/simple;
	bh=58T6L8zY8YnAabkJIK6RV974jXsNeGtFbOn8Th+ho4E=;
	h=Message-ID:MIME-Version:From:To:Cc:Date:Subject:Content-Type; b=CRZwifTeNnopVSMeB2hcSREScgj+VQgU69l5xV44I/7VhpKoZGO7vOwwcj+R5c7DcOrmimxjYXaqGCLGq709XT2VUYRPHTkqcMPD5TlIVUNKGj/mRYnSuLB81zlmBVErLZ9lru/a9OYnC/bfLBSI7iyixq2pSeMj8Gx/Ci5+wCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLEueCTW; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLEueCTW"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38759bcd877so8398a91.2
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 11:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787855909; x=1788460709; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:date:cc:to:from
         :mime-version:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=58T6L8zY8YnAabkJIK6RV974jXsNeGtFbOn8Th+ho4E=;
        b=GLEueCTWt9v1kPJwUM6OuesuBRiQQWsBQWLUDJVi5J9CmIP8B2gvNBklSN0kPFT+jz
         NWgm+T2b/tEbkZSL3A4iKP3ew3nCx3hEmeED9XHGHwapoaMc6X1ncDN+zu29gYwbPihT
         sP2LNnbUzAnxFyefL4qDH1aLFlrz/b99GZhF4vVE9aNu6ADCp2iHJoRokhJU1OisOmAR
         ZxiZvKINaZRSMqtIhQMp3AHH3ainjV7q/BuwWX4z+B4lwy9C55cpUMFv/SmGIv7LbDDv
         PFCtf93/+AuUUnPx1T4YXDQ5J7FQ5oBoM/JDmsPI4yms9n5RqzvQe+wguyTN+VV24k6e
         uyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787855909; x=1788460709;
        h=content-transfer-encoding:content-type:subject:date:cc:to:from
         :mime-version:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=58T6L8zY8YnAabkJIK6RV974jXsNeGtFbOn8Th+ho4E=;
        b=fPK5p61VXiHh16rmOA+wXCj/7i8l6BTNXRlPG72bnLykuZjfronPqRlVLWsgRQJZwF
         NFbTOO6//Clb0A20NpkkeG+MiVAKTise0t7thAb/LlNinJWinMN+2W+xNd5hCXrSshep
         npb8zpV8p0dSrXOHjBZRtF0TEuUe+v8lwhmXxpPCgw6IIl0iEXCoVhIxOeaoF9sfUvNE
         nHib8EishqhZl8OA5ZkUohuiOeLvJ0tGK4vhljyksu0gxsxq2XYDVfmNZ06o5NbyfPdl
         t2pWQCBPNlUPlwHuFgkkGXisXjsVVA0aPHTV8y1etiWw+EayuQLbdPk2XVqcAMwRk3kX
         pIVg==
X-Forwarded-Encrypted: i=1; AHgh+RqTlU7i0JrnmCn/mEwACbhQmG4M9F2d7Fb6QmZUdL3jNrL2yU5GMcV4dEhzREbwgeQdY1rv6wg=@vger.kernel.org
X-Gm-Message-State: AFuF++kUTvm55dWXmV2xqZEYzEYU+YgCjH1d/G8EXVHMRWEkkKhf50S1
	kiqzs288/rR+wyEq4kBLGcmepbTYWWujXPdm+3C252Ed6bWOgpp6e6qgMny7kAt/
X-Gm-Gg: AR+sD12q4mNoO26FcaJ781+v1AJxxroZGXCMMpS8FHymJw2oai6TCbGrbbJ4dkgw7vN
	s/u2XO3l6gvexNxfNmhJDsmCdLti3sJ5GFiqRn6eTll+NZlG8iM5Enp0ZroanRfArex5syRH5f3
	vqATPNnD8oQQ0+igpGkG4xfq5ApR3dVZJCBJqMi464YglS5znPfNkffj8I50eIAq0zyzHZd0FBq
	zgTL13hKMCRuOrHEcWB0by95rnLdrqUHKHOmhbqibfIzJSvNI2ew/gKkjxEVjJqeB/JUSGuOXgV
	wEjyf559QW/s5vPgChNtVL0LL8plGKhU/8uw+EHLAEd9WB43Z3UsRD0mv22RzM6zGMsKUOmlm8w
	p4z0bnbUBhToLP6bn70pC503/n3n0Y2amkzpqHqKUpU1UMKzCzQ167tcEY4x7tKsUNKV+ddvgyf
	ciVm6vP2PZPZcTp5WNLILGLC/EMwEK/F78721xayE5FxhBeurgDtITEKWXSt0FqDDN5sb31Rdsn
	+IPGfOdTAn0ZYeQA/yqWE7UoF8r3vHoFBLVSEmvIsJ+xtr80oONQZPKxw==
X-Received: by 2002:a17:90b:2f0f:b0:380:540:d499 with SMTP id 98e67ed59e1d1-396d0ed0023mr2507141a91.6.1787855909342;
        Thu, 27 Aug 2026 11:38:29 -0700 (PDT)
Received: from manush ([2406:7400:94:a5e3:4457:ae79:9170:871a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a8eefd98sm35452937c88.3.2026.08.27.11.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 11:38:28 -0700 (PDT)
Message-ID: <6a908424.0318b02e.61962.fb5d@mx.google.com>
X-Mailer: git-send-email-equivalent-ps1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Manush Prajwal" <manushprajwal555@gmail.com>
To: kuba@kernel.org
Cc: sgoutham@marvell.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Date: 28 Aug 2026 00:08:28 +0530
Subject: Re: [PATCH 1/2] net: thunder_bgx: fix fwnode leak in
 bgx_init_of_phy()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Jakub,=0D=0A=0D=0ASorry for the confusion. Patch 2/2 ("misc: e=
eprom: idt_89hpesx: fix=0D=0Afwnode leak in idt_get_fw_data()") w=
as numbered as part of this series=0D=0Aby mistake -- it touches =
an unrelated driver (drivers/misc/eeprom)=0D=0Awith different mai=
ntainers and no netdev-owned code, so it was never=0D=0Ameant to =
go to netdev in the first place.=0D=0A=0D=0AIt was sent separatel=
y to the correct recipients (Arnd Bergmann, Greg=0D=0AKroah-Hartm=
an, Serge Semin, linux-kernel@vger.kernel.org), and has=0D=0Asinc=
e been reposted as a standalone "[PATCH v2] misc: eeprom:=0D=0Aid=
t_89hpesx: fix fwnode leak in idt_get_fw_data()" (using=0D=0Adevi=
ce_for_each_child_node_scoped(), per Markus Elfring's review),=0D=0A=
with no series numbering.=0D=0A=0D=0ANothing further to send to n=
etdev for that one. Thanks for flagging=0D=0Ait.=0D=0A=0D=0ARegar=
ds,=0D=0AManush

