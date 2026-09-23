Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74025233924
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 04:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790136107; cv=none; b=uWpzWY82t46jxVejoWxNgbeUXSA5Lm1+n2K4D7QKwMXTrMAgCzF9xw4pU25SU8GreoB3iy7b8U0lYAvmTZOY/hsT+qi/6XwTz6cRrF+qXW0SKKCDkJYkEyWywbXs6tWA+n8rRsfIn4MHgEt7IfQ674LN/oiCEHBhCvPGPIbDCvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790136107; c=relaxed/simple;
	bh=Aiui/GIoJbCp5ePGjQN2o24q/nO6aTBrIxDkg4ISXM8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YVRS0SL7+qBnQrA02YpMZzEsgzVXQSJT7tX4lfXovAcRI0ly9W8DRqu+R1Y1+6e60g4TyLg7fwku8fr7ecSIDO5hpytiWn7SXMvwY1kWJ4/UjGGTVnwL1ewdtpsBRdWpqjNXGMV+OWmyLlJf4nJ6oaHOK7l6gKTewTYN5fy/kY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKTiO1Cl; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKTiO1Cl"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144f47a9b57so496828c88.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 21:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790136105; x=1790740905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iNH0I/YGSZc1C7h8dwe3uxAfPvi2kXhEcwNb2Q7F9uY=;
        b=QKTiO1Cldfh6IiupBczGedk8TcuH3d/+Ilc4weLHgSy7hRQpL5nSAmK3lTnsDc4hWW
         6eK+aOsdJ8IBJNP1UbIHjzVqhCAGkbWrCaWboazJODCTCYRRb72x8qpg7IdtXUSVEJ6J
         29VIE6D4DU/5yI5I7gv1Nzd2g0SIX7TUCP7EdnN3mkpPFwPhx94rF7e1pyKfjTTrwjkB
         FwLGujxUVrnGbaP1a4Tora/MjdH3zM6aJveNkiV+GpiBe2JLGzKedjS7Lli6sV2vcsXo
         dGFTrnGHwajgHe15xERAlkiK9H5qEqfMUanul16AEbK/GpM4uofBZPbfJ+9QXWE0gXcm
         3PFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790136105; x=1790740905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iNH0I/YGSZc1C7h8dwe3uxAfPvi2kXhEcwNb2Q7F9uY=;
        b=JmzUw0p/RsjEyBOLUP2izVqIAIGMG3q2hmoHKRF66vfI4Xm5Xcxl1K/lyhcUEs1YPr
         4FYeYdXgJpkoa1S6hSangkNb/bMy9hNSepVa+XrCLyRwz3gNvJ+FMsMDONA+DdsRWZOb
         nbVob75kPOc+oVMDujgNodZfrqxC6q2wxi2jxk2/Mh/+EG0AFqWdVjTzyQQ3dmiZgGFR
         n+byTxEsVRYnEqH+UOrzDHegLt8eoGjP5QEWE7QKLMlCtoiuIG4JkQECJygx2sF1CYH2
         /VLzLHdO1cQV7qQsIfSyiLuvo5r+rECEsz0Hy5RFHgnp/oTrvvQd/EGstBvNH0jzUskO
         /2Hg==
X-Forwarded-Encrypted: i=1; AKwUvBwntURdrn7YN4BcCPgz5VV9TsTlF41GZrAmEFrsBRGlGj4TgFeq6epNVRpwifkIH5LEIRatGEs=@vger.kernel.org
X-Gm-Message-State: AFuF++lS/r3IavxwAVxO+QjdVlfw8mbDlQKSJAH7rfvgmQHkWCtQQAdk
	fjh7n7B3xA24RmlRk4guyPUddQUF9NVURqDStQAtJX7qYkGf7MyEcck1
X-Gm-Gg: AYBFou1NQhWOtilYQJjJT1JU3Kts/c5ifKNrOdvn3iONIF/NrqYfwuDTPCNDxax3rrr
	wC1el84+8DOSvTdfk/a6sGhLbkzNSDUfwt0TzXIv2hSjqqdSVBbMEc7e22GQv43+psDW/QDlwpV
	3sVdaBgBZ0xGKQbm6RvbYR3heGzWDOy5J+3o3juYGmNyMBpeW1RjGlP32n2z1x06+kSvWKes+ZD
	XSFmuqCYCOPYRjazV9ud/PI34G/Y0CuWifwlDQd9WW0ucz84rlgYMaWgmw+10nAJY1zCbqEROlS
	Eh28zcCyZxnxKPt9H8FjA47OVOMD+oeumlN7MFDxPEBme88SpHm+SRVFVNzCaK8/pL2abnLPDW/
	bYt98Ci61GVyradz10eaKgO4vnju664NtSiNhLwWl12ZYLlZu8FQ1xtaZGaXDQoVb4OzQyLlDxt
	34FfWXAxxHOUNkyWEz0Pcg4QYYGnJDRvgFPMlKtLuUaZSUF2BFgQZ9OR/fUKHfvu/NIjpOZf7Wy
	u5OZPjDsCjuHVSi66tuPQFIR9ABjx8bFYuJREwLjT+gsYiRMdjtltpHolPY/2dJu654nv4Pcpg=
X-Received: by 2002:a05:701b:428b:10b0:141:52e3:85fb with SMTP id a92af1059eb24-144f90d9a4cmr1727836c88.5.1790136105360;
        Tue, 22 Sep 2026 21:01:45 -0700 (PDT)
Received: from Inspiron-14-5420.. ([2402:e280:21c6:671:64ea:2efb:709e:b783])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f9390183sm2426374c88.0.2026.09.22.21.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 21:01:45 -0700 (PDT)
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
Date: Wed, 23 Sep 2026 09:31:36 +0530
Message-Id: <20260923040136.13432-1-hemendranaik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922180458.5c54ebb8@kernel.org>
References: <20260922180458.5c54ebb8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jakub,

We have vendored the temporary UAPI header changes into the GitHub 
development branch (https://github.com/H-N41K/iproute2-next/tree/fq_pie_class_stats/)
as requested, so it should now build standalone in your CI pipeline. 

Please note that this header sync commit is not present in the official 
iproute2 patch submitted to the mailing list 
(https://lore.kernel.org/netdev/20260922211139.38570-1-hemendranaik@gmail.com/). 
It was added to the GitHub branch strictly for validation and testing purposes.

Regards,
Hemendra

