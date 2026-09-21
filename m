Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8701722D7A9
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 03:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789961321; cv=none; b=k7LFg9m2kpZyA5HgcF5/4ShFPDqYeLie0TGpU4Yk3MgInjgK01GGAbiWjJe1GzVAiGbjD8q0RyahcVADpJoWQsTW+hC+QFj63ZeYjUr63FiE3L3bVJaKSs7KbAoKpMSJFUZ4ilGrB/smKv0vMm8jK8R52BeheKrJfEQBKaR0ZHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789961321; c=relaxed/simple;
	bh=XPHufAaWv96oqPXlYKIZPXt1hwnXdBDNCJI2CHfFxHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DHSKS0y+phpH9f+J5kjRJ1XpHB/UNbvAB+cePR0MEsbonJa1vDOnbMQP/7iDvTmeWEJcwOqErAz2ChvQj7qMIQCmXAVzECKvEs/168HisjyDRlc6scBQGYze2MSGi1BT1CxatqgUpkJZHjXxEYCNTwxuWy90OJgkGFM51To4vak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mrvp09Pt; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mrvp09Pt"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1cea34f01so2115651a12.1
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 20:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789961320; x=1790566120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XPHufAaWv96oqPXlYKIZPXt1hwnXdBDNCJI2CHfFxHk=;
        b=Mrvp09PtMzvwpkziAISr9XDITETTwRNeyBJkVZrExHNBVaYS9frTU+vH+PkxIEpE72
         imQ1M1yakF6oOFFpjaY3KnBCxe9P5JIJozdXEcvpxUx6hA+jzfy7JlZgVjqQzLWQTRB0
         7/nSvLbfryI/XLSDyPW3SsfbJJnbWTKTLJZLrPtx4InKe31CxDi2NthbStrxfSyW20BU
         e0VhGfn4LlUU5pPTYXz9zffc7e+oWxNX2HPEbnnPtKVv8LXvASQCBh9ax/F0x3HuRON4
         3tRUGcudl9A3RgDobZZyAcKOj4NeMFbmASylJS+X4m/cQuO3/eo3fC/8th8k+fi0Bqxq
         NXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789961320; x=1790566120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XPHufAaWv96oqPXlYKIZPXt1hwnXdBDNCJI2CHfFxHk=;
        b=MTkzd77HHiBWY10sr+NdCL6tceekJjjkq4+Z5OCiqjR6oQqQDG2nJ+1stoJwSXhzPy
         FmSo9Aw05x4xx7VLwz0rFIcVYmKNEK6MCcY4Z2poM2xrcMPGlKizHRoDf8CidDJ+2wWJ
         z/LDkdj17AbtjOAEWSOg21myfGUQB27GKEKs0wmWjVHYE+6EPjqgvZy3TWw8tyK7ZW/G
         swS0SlKFQVHoQkPw4CHBfFz+VqVG89b4Obydj1w4ISWm3Ea9C9cZZa785HLqDdWMxJVI
         UH3yFk34lLfR7OxZAnXNsyNXnKuSxjOiwl0lEW0x78FpwBMAJWnB/6V8GTcQEo7DxShr
         SdoQ==
X-Forwarded-Encrypted: i=1; AKwUvBxQq0p0QYc4apsSHx2dRpJKNXwFCTA5dETm0rCYOQ8PYonsMvK4/9xP14R1+dMkaYTKkev55YE=@vger.kernel.org
X-Gm-Message-State: AFuF++k7ETcVit/PUt6/PZIMk1TgmGAbH88IdXaYTisAiFSWkdgKs+aC
	wxMToP+00sBKnlnTqs8k5FD0piGRr1z8MQldfmPaKEtoY+1Suwc1PfB3
X-Gm-Gg: AYBFou0wlmuwGPUeT0Y8/PwBN67XEoJpJAbR6iwndJ3RQmYMa6sp1pIM6Sz2+W7cPjg
	wJPo7VF75nnVrN4pF6tIfe96S/zJyXWPWkv/0pKfIHtlEZPc0U+uYNTfjE/Ymi2/Y94pl33AUlZ
	GYh9UUC+x23FIXackKIWJfTvAN74z6q9n9W6GpyZ8ha76vuK7D3WrtjV4VXBSsy222Rw4vrQ/Qs
	39cdp7t+uIXjRohRmrBdFrC1Lhe8rRAYcjKO59y460eeVP6buoUXuo3rBa8Esx2Llq5FeYAMBzd
	PGMz5dmnMhdLikv+J5qhdjY2aSBk39vn9MCphJk2h+S63UgwR3dh0WIQaytF28/1HqPWw9OOe9P
	jKPaMn82IHLIOHs1Rvph3R/uxqBF7LpyQfSAlwboU/6aIcgHWIPNsqn+Ka7NaYAExi7yCn7Q/jT
	IHGSw9RJtDTgYtuibZhTu7Eobejq1pYU8dOI2y9j+AA9YWl/Qpo3sbDJICtQMdBOYFCGBu8tlYc
	Tn1bi4A5gk846SGQ7z3s50VlY0SunFSDmFVtItCGlOYaCqs01cf0QBZywX5mlLQCWiyMN+vBwxg
	+2R4
X-Received: by 2002:a17:90b:5705:b0:39e:2faa:2e83 with SMTP id 98e67ed59e1d1-39e54d1e044mr15045770a91.10.1789961319791;
        Sun, 20 Sep 2026 20:28:39 -0700 (PDT)
Received: from C9P9279WY4.bytedance.net (21.186.101.34.bc.googleusercontent.com. [34.101.186.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c37c8e7sm11448715a91.9.2026.09.20.20.28.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 20 Sep 2026 20:28:39 -0700 (PDT)
From: Tian Xun Ng <luckilystar08@gmail.com>
To: emil.s.tantilov@intel.com
Cc: Tian Xun Ng <luckilystar08@gmail.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	aleksandr.loktionov@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Tian Xun Ng <tianxun.ng@bytedance.com>
Subject: Re: [PATCH iwl-net 1/2] idpf: keep the mailbox up while tearing down vports on shutdown
Date: Mon, 21 Sep 2026 11:27:32 +0800
Message-ID: <20260921032827.32485-2-luckilystar08@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <45ffbd03-653c-46fc-b500-07e9b99f295f@intel.com>
References: <20260917105205.37561-1-luckilystar08@gmail.com> <20260917105205.37561-2-luckilystar08@gmail.com> <45ffbd03-653c-46fc-b500-07e9b99f295f@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 9/18/2026, Tantilov, Emil S wrote:
> Actually we can't wait on shutdown. If the MBX is defunct, like CP is
> down or unresponsive, the shutdown will hang for a very long time. This
> is the reason why we wanted to avoid communication on shutdown. Have you
> tested the shutdown after stopping the control plane?

No, I have not, and I cannot on this platform: the control plane sits
behind the device and I have no way to stop it from the host. So I have
to take your point as given, and as written the patch is not acceptable:
each teardown transaction uses IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC (60 s),
and the teardown per vport is disable_vport, disable_queues (which also
waits for the SW marker) and destroy_vport. With a dead CP and two vports
that is minutes of hang on every reboot, to remove a fault that only
shows up on warm reboots. That trade is wrong.

What I would like to propose for v2 is to keep the teardown but bound it:
a shutdown-specific timeout, on the order of a second or two, used for
those three transactions when the driver is shutting down. If the CP
answers, the device is told to stop its queues and the stray writes go
away; if it does not, shutdown loses a bounded couple of seconds instead
of minutes. Does that direction look acceptable to you, and is there a
timeout value you would consider safe? If you would rather not have any
mailbox traffic on shutdown at all, then I think the fix has to come from
the device side instead, and I would rather know that before sending v2.

> This logic already exists in the reset handling, there should be no need
> to replicate it here. Do you have a trace and/or exact scenario that
> leads to remove being called while in a reset, but MBX is still alive?

No, I do not have such a trace. I added idpf_is_reset_detected() defensively
rather than from an observed case, and I will drop it in v2.

For the record, what we do see without any of this, on arm64 with two idpf
functions: after a warm reboot the device still has its queues enabled with
the previous kernel's ring addresses, and the first queue reconfiguration in
the next boot makes it write SW_MARKER completions into memory that kernel
has already reused. 20 of 20 warm reboots on an unpatched control node, none
in 151 with the teardown messages delivered.

Thanks for the review.
