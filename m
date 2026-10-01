Received: from mail-oo2-f38.google.com (mail-oo2-f38.google.com [74.125.231.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EADA33A6F1
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 23:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790897646; cv=none; b=ptHQjzC8mN2PpYUQ3i0l6AvT89vWiEj/vXhqlmY0pXJPv48R/zLz4c9ri2AQLOObhflsySaJQJO43/HLaV5ORCWgUN+RWqyjtmf4/IZnDtTStTzzvS6Qz8L43S0C79F6O3plECa7QrKL90A+c8Hci5aEJ/8ofQptmC/Jov36lxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790897646; c=relaxed/simple;
	bh=5ECVtE0WiBYLfGFk+kpWXr/4i8mDtbhUhuO2MP6x2LI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=obiUo0rKLNnRWydf3yY8s7X1DXl97b0na+4ozTZmiF/4T6DCpLt0lrafwwCGf34B9ncfsZ3+9wdd72EnxT1GT1ob9LzS2pzrfzku8RnSHZH+xla5BUSBeb0zlTHDU0bDL0bftloVxa8Vujd2cbms6eGFJfeBzokU2IG6NFtg6FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=FAFlAwcp; arc=none smtp.client-ip=74.125.231.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="FAFlAwcp"
Received: by mail-oo2-f38.google.com with SMTP id 46e09a7af769-80a18990c76so4539958a34.2
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 16:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1790897644; x=1791502444; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5ECVtE0WiBYLfGFk+kpWXr/4i8mDtbhUhuO2MP6x2LI=;
        b=FAFlAwcpCIE32KmG15bPV6djIiD1G9NKzmYT6NfYF0IUiv+XSbpJjUp1822V0UasA3
         omc4hfWG7IqC3PyEkjXm2Rzjp2TN1sI9ZGjaUrbvH2c3Szrs71BcW5RufOWdDXZAyTPo
         CyWjciMMmcXVyhYwU2RZTfrrfcl8t3jVoqQ8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790897644; x=1791502444;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5ECVtE0WiBYLfGFk+kpWXr/4i8mDtbhUhuO2MP6x2LI=;
        b=JcOnGIUVIq8fBnHJZiEd4xj9YOAthfm7h1yKZxphuLAGXZuvXTE7OyaCNNrW4kN0Ih
         WXqnx7NwW0CjrOhG8V1fmIQFWXMu6hwsp33J6rUoRpixKujc2gI+iyyOSoJmB1P8VEn7
         Hf+EZErIoL3LWTLOk8YHAD/bqBBKaayt3G7rJc24KlfPCvTX5qbOzZkcbBeBGD2/JWnm
         ejUbdRm+4/9xQFvBVi00gFJEGpevhhkR40Kaz4qjTEJXbOD9lwMmhPy4TpcfBXQMHK+z
         fXt5TMRPuVRBK8xngpm6WmSCADQ7qDqrdwMPoc4IC4MNX4RArO7neQK17jOTiN1yMA0l
         +Vgw==
X-Forwarded-Encrypted: i=1; AKwUvBzGcIwqqLxYtkUUG1qFxQ36puGuT0Lvq1Q9wztJ9aAZmqRRxRQQ1xnE3/ElOtAYrXtuZPdYcbA=@vger.kernel.org
X-Gm-Message-State: AFuF++nPq4bUoHoMtr4serCdRFtp4tO1WFRcm2Pu468NGnGiy8E82gA8
	f/nHpUZf4ws+XP38CIxumLypym0afrPW/bMHG6y84XBRUfFIg6Co08NxNjuRaXGnQvXco19n2Sg
	pXDYCoUM=
X-Gm-Gg: AYBFou0ZMDFPv2kkCbZCo5Xq1lCMukPB7Jv3CXk+DA+1OcBumfqm4IwhRGZRbPuXOT6
	eERK+Vd8dY1YjXW9tU2ytqtvbdulqgqTNaOae8Tb1dwgMqDz3YeYc10eNkTn6FLA33HiJXPoYac
	74kWF/JjxxuAM7/0WlSOiFTodmFw0enRRtu+/HB3/P8wODIagMedMgPMToCdX6228C3JC5c/L84
	kWtOLTVhokJIod4PZG4nBBT7/UHVyxSnwK0xidL7G3bm4ISkozn4axuOfQMTBwDgtrg5DSIBZT7
	YTDLDbMWyzS8oEU5txRWuKRGv6L/s0K97zCPKQNVZhnrUFlcsB2do0724xGAeOHwJ+XTrgklVXx
	WfgYGKo/EkOe5tgLz4iSD9qLkQhnte7ucHM0CijWNuuM5gBSejIcoyjGAzGYMRqf3zyYlElvJLA
	hCgobDVVc/ZieG3/60TItYXqUgtw7sDoqNgLUH8YeizMGrrRSCuN/GL54xDvevrqSthOIPZawbQ
	DmrXTDvNQkX6UVs4erZktRmnEzERUeqpPQ19qbpEvw6+t+cm0kUhNSQD4QjlJ/Qr7pCrcrwZGbX
	Lt8=
X-Received: by 2002:a05:6808:1a06:b0:4e7:3fd7:2752 with SMTP id 5614622812f47-4f52b1a630emr589736b6e.54.1790897643831;
        Thu, 01 Oct 2026 16:34:03 -0700 (PDT)
Received: from com-68297.corp.openai.org ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4f5243d47absm687513b6e.8.2026.10.01.16.34.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 01 Oct 2026 16:34:03 -0700 (PDT)
From: nramaswamy@openai.com
To: Jakub Kicinski <kuba@kernel.org>
Cc: Neil Ramaswamy <nramaswamy@openai.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net 1/2] tcp: restore RACK list membership when undoing loss
Date: Thu,  1 Oct 2026 16:33:50 -0700
Message-ID: <20261001233352.75988-2-nramaswamy@openai.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001160720.0a663ec7@kernel.org>
References: <20260926002520.42955-4-nramaswamy@openai.com> <20260926002520.42955-5-nramaswamy@openai.com> <20261001160720.0a663ec7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Neil Ramaswamy <nramaswamy@openai.com>

On Thu, 1 Oct 2026 16:07:20 -0700, Jakub Kicinski wrote:
> Could you add to the commit msg if this was found with an LLM scan
> of the source code or its been seen in prod?

Yes, I can add that to the commit message once review settles. My investigation
started from seeing repeated TCP stalls in prod and the mitigation that seemed
to prevent these stalls was limiting SO_SNDBUF to 96 KiB. It also seems like
others have seen similar symptoms before [1] but I can't definitively say it's
the same root cause.

[1] https://lore.kernel.org/netdev/35A4DDAA-7E8D-43CB-A1F5-D1E46A4ED42E@gmail.com/
