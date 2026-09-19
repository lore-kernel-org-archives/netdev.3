Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B6932B131
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 06:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789799182; cv=none; b=QpHoHzPqtNKXBmE9CTWl7Vl1h9R4pRl7qMteg4v3ws7fC+I+JtsfK+VR+DX05Sbe350HqHmOtdcSo06dmml62xyYFHJ4ryuEJJ8PuubrCnHQH52ueKuGl5xKLw7HKxJd3IKF6ImiXR5mjXybweU35BeV0FMzmpHX1OpjPX8OQUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789799182; c=relaxed/simple;
	bh=RI0ZyrQb4ytJDsiZVvOM12kdk0OUkZvDp4TPA2K7Ci4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MQnAmNM3iN5BX94eLKyOhxa0nCBy+yIf5oR43GsGBceoszK9pYMJntiQhp7CYk/xUJPDiLG1LJ3ONDA+V5O2saaxNkloI7lBLinC+PI5mx9Atl/ET83rsWVeVGxulaRpprZvCZ44P/i7v0lYQGGax3d9XqSfNXVOhDUgmdORHU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMKr1klE; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMKr1klE"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469a34908so1423528b3a.0
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 23:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789799181; x=1790403981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gsbsJnG4mmaQW0/v8FF/QfgvuP03odNJwcWgXIjZTuM=;
        b=WMKr1klEL2EjBRHb9nE4HRvfFZzbj2oGOa64zPPDjO1wXWp2GBSS/kkURwj61Q2zsL
         rhPKDYX7fMcQJ6VBW67WaX57V88AZ0BCFv7+pgRxKECnZt1QV+wyoh5iU0WPwkMfWXNI
         y23/WwFUbwaxvVHGuZIpSY0Zo0BQLW9N/46WpoU/fEqZLAVEFtyozKeKsS6a/d9tv/wL
         JE7MurYL99A8ydCC9E6pBM/yn/HOOEskiUkcqOR/MmFCsi8sb6J/P6lpea4mdu2wBEzD
         7oArvDleRznu4XcBvFWQTpN5nr6ud/6ws+nC0b/Y8ADmU7fIqxHdpL0Q9EIe8EwuyxbY
         +LsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789799181; x=1790403981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gsbsJnG4mmaQW0/v8FF/QfgvuP03odNJwcWgXIjZTuM=;
        b=P14tGkMYsvr/Wf0Io6Z3A/1s68/jDXET5MHxEJYpmhvS3ikOO3+52LzBsVK9K/AgFm
         nRfnjAuQqdoOUVMyN3Tx0bXX/eKnA4At7etk9mJCizRJCz6gBf1/VSM3DxsFwJo+xVIK
         03GVmSzQg3K9AiHbbagcgLEJeyk5zgmMrwQCcTVMiJLtBVMUebwxMXDCHWAaBzuiEj94
         h36Dp+Li1lDjw5kWMgdVfnwBCMcIRuTkI0h9boadXvUtHCEbzKk9fMmCzjSQzcIu65er
         TT5OPKpPQldIBJ/zLnuZpNLxnR0uSK1/+N0kWaWNhA9lmxdcp61UMplTL92WpSZbstdc
         H5uQ==
X-Forwarded-Encrypted: i=1; AKwUvBzOzEC8EtU63rdEm/oaBo10KfwQHhiDtrNIwB8mQ3ic1PhMybXW294CanGCTIR3DjJ2fHQ5TD0=@vger.kernel.org
X-Gm-Message-State: AFuF++ndJ5j+MxYwXE481mLmFoqyW3I1McTTMlVeIc846UJ+n90Ryd+4
	P3dlvEcdQeSQDb1Ll0nLILQP26NuwuPf+lUqg73pL4swBt1jcpMqsXrf
X-Gm-Gg: AYBFou2SOZsb2Bo2Km+DW5HIhqGR8W/+AHx6/WQe0e39x67bKInl9hzupv73wLbecpC
	t+F3oM+rz+WkYFYiaNvMOyn/LsKrm5BAlBPFO1/ktXnzjS+ExFIQKIRwAX9EloHMyfXDDPv8tkA
	gQPwaa/VarAF6OSry0OafU8v80fY4oRrpehkxWttdkFxkR9i9zIaA5t38q21DJ39L9F5klgtXrH
	3ud/GF2ocbmWoIc9O0ayCGZNDILBoFOTT+B+ggAbWECE4y75T5DBLRqhWLw2tIqRYOO7O2JTApa
	sJBQSFLYVPKI1ETc7Y4Juk9KR5nXM3w4nMbidTgpV45QwwbVBd43fAeEu2Z/nGFZlNAxNrokNjk
	fF2027C1Tawyvfl6n01tL1763nzlZnG+IGBo5k3XIdQW61WB4iOr5nRe2U6Ru0wV5VQPBa1OCKI
	ZfbBzLW2qqKUgRiNiJ1zVPn0NLKeAEno8XhxcySsMNurbCnfs/gPop1oFqNU78+FuYJJw4G+X1Y
	MWyUIp0YuFlBH6SjwklY1jOpacUVfeKDjt78Yu6UkKFNTn5ukGUyf0JTHh1zfbEff6o7g/Fx8Y=
X-Received: by 2002:a05:6a21:a393:b0:3dd:a196:69e8 with SMTP id adf61e73a8af0-3dda196789bmr2864142637.67.1789799180848;
        Fri, 18 Sep 2026 23:26:20 -0700 (PDT)
Received: from Inspiron-14-5420.. ([2402:e280:21c6:671:d11b:773b:fa83:c49a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c32da4960sm4310485eec.0.2026.09.18.23.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 23:26:20 -0700 (PDT)
From: "Hemendra M. Naik" <hemendranaik@gmail.com>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	hemendranaik@gmail.com,
	horms@kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	tahiliani@nitk.edu.in,
	vishy0777@gmail.com
Subject: Re: [PATCH net-next v6 0/3] net/sched: sch_fq_pie: add per-flow class statistics
Date: Sat, 19 Sep 2026 11:56:13 +0530
Message-Id: <20260919062613.42379-1-hemendranaik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260918155906.13d01c2a@kernel.org>
References: <20260918155906.13d01c2a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jakub,

We've posted the new patches for kernel (v7) and iproute2 (v6) 
after rebasing.

The mailing list threads can be tracked here:
- Kernel v7: https://lore.kernel.org/netdev/20260919060125.38063-1-hemendranaik@gmail.com/
- iproute2 v6: https://lore.kernel.org/netdev/20260919061254.39678-1-hemendranaik@gmail.com/

As requested, we have also posted the latest 
patches on GitHub which can be found here:

- https://github.com/H-N41K/linux-net-next/tree/fq_pie_class_stats/
- https://github.com/H-N41K/iproute2-next/tree/fq_pie_class_stats/

Thanks,
Hemendra
