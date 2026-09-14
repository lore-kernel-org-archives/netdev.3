Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86F23B05AF
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 07:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789370652; cv=none; b=FLLBdCZaItfRAhHaZiBFvTMsWDuShGT6Fq2ZUXYAlnKys8tWY0gtRa+bYNVJ0UG4fcbW9E78UpbWt4TNJ2ha4hWFXEV3f7FklFhGUrIQ7DhkbL5/wya1z9rA9rQyTePoeSSKfnO0k5/0cwTxMib8gExTNOZZeMdMR68rEQRS7v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789370652; c=relaxed/simple;
	bh=SS1ZM6np+G358NneV4rAvq3tFZOwv5s0KtkiHwfNVsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GL5CksIWNjEtaxGzchSgmr97hq2PkShT0QMV2sDmwWEQFSouL3g9fKvbxK/SAOyt/ZDGqKJIB/bx2F1Vw0+zyhkBm4VKGsHmS3f+Gz8VjY7aAt1ojkDmH1dO5vzA4ggAV7fE6AuUTyz2yxC1mR8p/Dvrfva5y65dk36KB/QrVuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJcUpq7y; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJcUpq7y"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4998b5a63e2so32120305e9.1
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 00:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789370649; x=1789975449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3TyhN7mBsHX4emCP/4vVQ2eujyFH0u498W1mC0U6mLI=;
        b=gJcUpq7yV5fbowRp1yXdel521ehPUfI9OaI8SpaN/AiMxt6Z+o0guwniewoomExrPG
         cmOuSRCHahyYb7R5I7yfQwI3yqIoMCXochbf1Zbkt9Br7F5X8hFrIFd/jCS37jBWJjUl
         MdvFoulDLhZoUtxTNmyKj2hnH9zEOiGBZG8I967kr1TM8LCqYhvxie/YQgu5fY/8xKn/
         tCVnSgFVyDuV7yqWmJI93dIGBK8D9ImVtTfzPBLLXX/cWy4eDfnbzUDhDyj2f7UUOvgI
         c3KYlro3VIB7/2gCSNerDc/cAOp/dv4sLGpVzbL/amDhyu+6IPBVW6l64twmQVAXd/wm
         GRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789370649; x=1789975449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3TyhN7mBsHX4emCP/4vVQ2eujyFH0u498W1mC0U6mLI=;
        b=Ub15ZXpoz4is1S7uD4krZxXK08kBO5adX5uA3znJzb26C8QYqGpbLS9EgGtQyxJyDM
         waSUWowvTnFrNfR0BB29/C3hvt0rUCLHHSNox1ztAl6/FBfDQE4MosOcLgNWC/lYiwmR
         VFeMuJZR3NXiYOMeUYi4tczFW86eGjFZ3fyZ4p+2y8/KQPRdJPgIYKTgN1pGyepztuP5
         /a1eD00bkxUND0jsffFD9p/1hwlbM33PhRrDktqFPv8lj/GgNj8BdSKUzSr+pZPql3MG
         g3nJ8LPXoZFRMi1orZpammVTU0w5kEfiWYNNnMFrVKdgT7Ewx8eyf0Ms0C6AB4S3AS4t
         xWYg==
X-Forwarded-Encrypted: i=1; AKwUvBwmK+yTkZiLzY4zuMACn5lrir7kuyK90P9a4HXAAnPDgRn8dy37RTFtzyVzi80QY0jvoufLCSg=@vger.kernel.org
X-Gm-Message-State: AFuF++l6eoHfdiqT3aYKocpoGnrg6qCpNcmULqbHExprqwvamSebF+/f
	pzMHJFYKkz4Pb67YV8GPSWBDCBNbbKlzwX5N/R0yaIAOFVshIE90xqbS
X-Gm-Gg: AYBFou3lcSqCa+ZG9dSKUCrE76SbtXfRUovS0MEobzs9Of0Cu7bnSkcRJniXwwb3tnU
	J9soSWBwBGvEK+xjDSkNmlR0bBemrfSQpuy7IeAMENwlZ25W/j9ZN2JN6PN56xFiERunwqKGC4k
	gUrZJnbLKdw/DvdJ9VHK2ak9Ps4hzYuqbFlNzfuhvGJl9JNvY3wRQTfMRrr0tVQpEnhQjfecrY8
	ylxJNnJQg7EtbrUYgh+KmE60q/EK5jTrF/XsdorS8vhlwLJDO8xnuYrZrpaoe8BjxyBf0kAY6As
	fhb7CDL1ipLWTF5R2V3ES8uYTwBJlAs0gW6FS7VNbH7MgI5rHu9ybCfId92ErMZt2v1ItxOmw6l
	EXB/jatj2gLfmZgJ+AEoo50nVtXSOcduZhLhuv15w/4JL0zrH0NxzfhjwQEbxedb58ncjv0dnc6
	JwOiKnuYZPxaj0ocLYQc1guk1mpDHE8B8jQWe6p79HCBhvCRhZONnY3gtJbqYEZ/bbRaY2IGS2F
	thde1THtg2eyuKZ7H9o/c41Z1k65AKnaznwEJk5BQINWvo5FlI=
X-Received: by 2002:a05:600c:8706:b0:49c:fc6c:be15 with SMTP id 5b1f17b1804b1-49e7a68b749mr14649275e9.27.1789370648582;
        Mon, 14 Sep 2026 00:24:08 -0700 (PDT)
Received: from fedora-tap.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e6499d57bsm439605585e9.3.2026.09.14.00.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 00:24:07 -0700 (PDT)
From: Sagi Maimon <maimon.sagi@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: Richard Cochran <richardcochran@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Sagi Maimon <maimon.sagi@gmail.com>
Subject: Re: [PATCH net-next v13 2/2] ptp: ocp: add TAP CPLD firmware upload for ADVA TimeCard X1
Date: Mon, 14 Sep 2026 10:24:06 +0300
Message-ID: <20260914072406.12970-1-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260911165105.4235aa04@kernel.org>
References: <20260911165105.4235aa04@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 11 Sep 2026 16:51:05 -0700 Jakub Kicinski wrote:
> Why add another FW flashing interface when the device already supports
> devlink flash? You can use component names to disambiguate which FW we
> are targeting.

You are right, and it is done that way in v14: the firmware-upload node
is gone and the CPLD is a devlink flash component instead.

  devlink dev flash pci/0000:02:00.0 file cpld.bin \
      component fw.cpld

->info_get() reports fw.cpld as a running version with
DEVLINK_INFO_VERSION_TYPE_COMPONENT, carrying the USERCODE of the image
currently in the part; that is also what makes the core accept the
component name.  The fixed cpld.id keeps reporting the IDCODE, and no
component still means the card flash, exactly as before.

It removed more machinery than it added: the driver side is ~50 lines
smaller than the firmware-upload version.  The fw_upload_ops callbacks,
the adva-cpld.N node, the FW_LOADER/FW_UPLOAD selects and the
cancellation state machine that went with them are all gone - and with
them a race where a cancel arriving after one upload had finished could
abort the next one.

The one thing that changes for userspace is that the image now has to be
reachable by request_firmware() rather than streamed into sysfs, which is
fine here.

Tested on the card: a full erase/program/refresh cycle of a 6526-page
image through that command, the CPLD reporting done afterwards and still
done across a reboot.  A .jed container and an unknown component name are
both rejected before anything touches the part.

v14 posted at: https://lore.kernel.org/netdev/20260914071531.11640-1-maimon.sagi@gmail.com/T/#u

Thanks for the review,
Sagi
