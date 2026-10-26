Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793022721;
	b=huA7QrWwvr+MYr/iKvYOgmypPf9Xdx54J6SrHxbrPJxtWQCoyMOPFUHufiAaZ6rVI03K
	 s+SUMhOxybZPNgdzL2okm0MbkSIbUXgYMwtYIGrQtZM2PwnvR9UYe+iePW8/tiqi+3d0L
	 RmyPD2eI6XpY/gKOBVHBqotXi3GhWqjGuQZj4RTE4+bzjX1nL+V22ayCM06iC4uiku4ph
	 4xDLjSXW1PNChQLqX72CGUYR5aLycFBnyDidPfCLN1bfQnJcHYQdLwUujzZtJvofyBTyh
	 MAWVptQYm0SdaNk/1pzZHR/VmHJSvl6IKPIFyHREDRwJPP38TH6Qtp/SOpbKKMorA0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793022721;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=yToqbndOEx+Hojl0phQ5607aWIXV5FC09eyMH7kbcws=;
	b=FlWpi8Wk4pdUC5Fd0SNJa/jw9LS0vgylsG6SKTaxvqc0K8KQsBhcrUVs7A/9GYHwMK2b
	 VggI1srQugIM6Q5KbiRt1L7VpPlhAf0KdPhJ5MdnN5gs05I/et8hVCxoUqu7EiKHV/+6t
	 Gwr69mTD4cd/JSOjtPI936E8FMRWVvh0fqQmlgi91vzY0PrZ+9EgesZKBJ/bxEjO3SHm+
	 VRVdTpPuYbAx6fkdC9uLaBoCjfsxOy+ppJooSCDAlZMVqOHKIbUkXv3s4KbDD+x+N0RHP
	 rl/nieZzkPeJEUEPI7BHJtiJmxQHtIWLjFg9TEPiRqdjP51wAOikfhM7HOKFD+FozCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KHj81qdS;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846C9606A31A
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 13:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 846C9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KHj81qdS
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a2084d62cdso23957325e9.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 06:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793022720; x=1793627520; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yToqbndOEx+Hojl0phQ5607aWIXV5FC09eyMH7kbcws=;
        b=KHj81qdSIlSFOiHthO0dlwcj+NjDovUfLvD+44dcsjtzW9O2+W/Et/Ud/nJM8FaFpj
         l7KwuQx93TM46UEIXphcndJz6PGzO1QMz0ZWcBeLzCbXS+g5roTPwf7kgEC+3Q5oOB68
         3Dk3RZ9Zs1X75896jcm/nD5wSw5PNfukwenR9dtUSofQmM8SF+t7XgBCkkG9t1Pf6ilm
         sseShP3+l7j4e/bmgZrTqzcCs7V1ZWqHAw4CFOBFe2UX1cYVHGJj5P/TV3pcnffTEDfR
         QlYsZk4vvrK+5ATPuRa/uXIJPRXb2qdmvQPOpkXH4wCk1zYjAlaJOOiZYgQKCJn3+gSb
         oHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793022720; x=1793627520;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yToqbndOEx+Hojl0phQ5607aWIXV5FC09eyMH7kbcws=;
        b=Yjan0FW6Mf78rBtDyFAFwJkUoiRZYDVC1IYKsI/7Rv242OfO40JtskCLLYv3dqo64Y
         5k0miMwSPwRfUj2xNWpr/9ZjFSJLbkJKO+NFC4xqgEQXhvW5+fQI1GqL2DuqmQRc6JSW
         6PWbBslvpJsvzy41D3vzEpJbh/wvnh6MpYtTPKLpvuCRxecdo+E5VE1bMKxcYK9uJZWw
         0Xr+jmL8ZzkTCEb5Dc7BgtXE0bClBbbJzqR+DSgRVE9vNkpSMv7V+V0hisVbFuCCqW2X
         Mt18eUXdMVEbn4MhFmTS6aPAOvM3nObJNKHdgr/1nvjVip9SDkPyGAdTVJURciq1x2V8
         atkQ==
X-Forwarded-Encrypted: i=1; AKwUvByC++y8TqFNI0+uJD8J4nV4n6I8Mq8e3TqlxAFLE416yXzXFdvyVuojnF/3RvDIUvcn7b6dL0g=@vger.kernel.org
X-Gm-Message-State: AFq9FYI1bL0bMcfg4zSpkJuBJ+sFMZOldqM08jr79lfPb9BAGdcKgSND
	OPeuofmVvrBBrmY4+XyvUJl29aJwtqzCA5wY0RubFxgcGLJwrIiUaTA=
X-Gm-Gg: AYBFou1umptxn0pGRZ5OSHj+n9/I20+cthlkUVKeU0luery/9+LLwnDVLyE9gQHj62B
	lZFRoT1kzMm8F6oR5uwrNWJwtfFM/3erhW5gjpE+vbSXRdysCcoWL3fKoY/BqHJIpkaf+JBBMq3
	4hdu5U1MOiUSfDNFFUbUssFfyikWL3esRVNioxLT1lVnP8S1CBMyWnNV9Id8+em/OTd+qBaKdBT
	Sz2VBmdXRn5hYfpIBTl5QqEHaFl4RqsRbwQvnYJhfZEs5SQCnJH4GjPYnOk4FHDUHOiwx8sJtPa
	DaflIvripOAulK3pKAje0UfazJvwaZ6FwrpXcYirmbjk7LlsPkoo/oG8XQbRhHWwo8aO/nsjm+X
	3r+XfZ/rZgip3tDU1Hv+7CjS5yQ5xiocY7uqGMS+qObLFws6TzWO1ph/1AUnBhGlY3drzm9CvfN
	6x3NBiiXZO9vYNDG2wzNTGW/fPvJPYcZHi2XaWuOPeSOHzLz35ht2cu30mqO9U7y+Kv6wf/hNhr
	aDY/sh+2C3tKOZKrQJPPsE/s0FlCBiCARU=
X-Received: by 2002:a05:600c:a318:b0:4a3:5aee:2c25 with SMTP id 5b1f17b1804b1-4a35aee2cfdmr94233795e9.31.1793022719649;
        Mon, 26 Oct 2026 06:51:59 -0700 (PDT)
Received: from debian ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a574088sm182895725e9.9.2026.10.26.06.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 06:51:58 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: netdev-bot+sinfo@kernel.org
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, mkl@pengutronix.de,
 socketcan@hartkopp.net, s.grosjean@peak-system.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 net] can: peak_usb: fix use-after-free on PCAN-USB
 disconnect and init failure
Date: Mon, 26 Oct 2026 13:51:56 -0000
Message-ID: <179302271698.3957649.179210854484018832@talencesecurity.com>
In-Reply-To: <179296234587.3327.17827320411071304419@kernel.org>
References: <20261025210256.629830-1-tristan@talencesecurity.com>
 <179296234587.3327.17827320411071304419@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

The issue was found by manual code inspection of USB CAN driver
disconnect and error handling paths, specifically looking for missing
timer/work cancellation before device structure teardown.

The bug has not been triggered in practice.  The race window is between
a bus error arming restart_timer in pcan_usb_restart_async() and a
concurrent USB disconnect calling peak_usb_disconnect() which frees the
candev.  The PCAN-USB adapter does not register a dev_free callback, so
the timer is never cancelled on the disconnect path.
