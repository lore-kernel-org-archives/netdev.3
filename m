Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31063AB269
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 06:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787121108; cv=none; b=FQE5J0EdPA69DL6qTivwU2XtarUQonxJD+gJi8hJCO3f1XYYt49XQDuv2mY6Rb9Aq0L9YqjGEv38rpyN79NGjXtdD4oCBE1YMwYgnQiX62Azia4Nwh+5E+b5Fv4cMmRQhUUEph80k+C/GPAIHmx3u4/e22VFyiCkYUMYb3q0TOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787121108; c=relaxed/simple;
	bh=JAFvzMiRdON0lMe8ik8NAxCqdOcMnqMxzTavkzE4gEo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XnTDLM9kqWLSJABZA5LVpfA3Ez2R6CbjwS+StvMaOJEiQiMVAAHcR41GfdPjD1iWrYpCZyhN1/mQDvnGXTBA1UmYmtaqIXePp3tGxyIF4VxYIEqnshllhDIsB6UWMArjvhnKsRCb3InYSiA/PM4sWJqcp92XhfACqyEQz+A1xvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YUMXSehs; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUMXSehs"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-66ca3fc625bso1196597d50.1
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 23:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787121106; x=1787725906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JAFvzMiRdON0lMe8ik8NAxCqdOcMnqMxzTavkzE4gEo=;
        b=YUMXSehsVKQtzMHtE5GRQbik/QKcJmM189V/WtQH44HTIfBwW+L+OuZkKMY0BKNV4N
         xTMrWvdYXLiL+Ek8hBvxAXu4IHo986Z9YQzB4ydmn1kPgSJ+0PnX40sQT4rkrwCCgEWn
         P/a8p1ViWJHwp7tFBf+/WqcGN/Is62Blng9BLZaN5qWEXKDbiCli/Tf2L9cLn0XT2EGD
         j5ftEIeuI6MprzidhHjpJ3f5IfSYgkWg5IXL7sEYKDKZms7nHXUNpyjCPXi0nuzSd8iS
         Bk37w09/IPDVT5V4Pp3WgCeNLyBgGVW/m3qB028GpJZS3nSN7nResPuGbedVv1oge9oM
         cuUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787121106; x=1787725906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JAFvzMiRdON0lMe8ik8NAxCqdOcMnqMxzTavkzE4gEo=;
        b=EsHRB0vJK1FOHMJn0uWLelLIq2LQJLsUqCtKiljJgB2eHtZamAtwHJ3EbociESrm0k
         BYydovAsXuDEQ/U+JU09jeubW2gO3SCb7p5XQirMWfXsNYoBi6ycuxLLCA1XqjPi1xnW
         Ka/LlEav38HEwQ9eW6bnF0833Rwz8zGIgjNDe1986OFBOs2qPcj6uRWhb1TIbpkMST0l
         O1GZo0qYGUPdpDAPdxWkzfic0uq0CXUwnGZy58+gmv8gbQ3I8TaiVh6GKaatfdoZsOZT
         a9a3QlnmbwqOy2vOoYb4AGiKeD/RqDPYobMVx8/yXhm6X4U1a6S/2YXNgt8j4Wu+3d8c
         0/9A==
X-Forwarded-Encrypted: i=1; AHgh+RpTKHA+B5IwmUSb7Y14xv3idFJWAk10L/PCLWsIfxKji4fVNrIVunPckNxbiwbA2y5riju0ur8=@vger.kernel.org
X-Gm-Message-State: AFuF++kNvwDm71mNywSWEeySTGMAln0TwX06rva6XMT8Za7lfZjnoknC
	Sazy+AWVq01ArmAqTSMqx5tOAGiiDvsX/EDUYA0tplAZKyDFEXms/kuz
X-Gm-Gg: AR+sD12uVp44XO90aRgDDblrckvRpXg1iuH0UZMc6hhs42/LhV+svmT4HxOooQeWQ+H
	L12vwxSqngnKzdbU3LZtbLq9XI2/RnFFhphMUjc+z83Zu2VR4QDqp8JYuLFDfJsoYSJ2m6k+Rsj
	sX4DViRUSj4eK5l0x2s4PfUvTiv9kjApNt3I744668etkzDFmYvPfszd7Q804M0oePGsupmNcMs
	Zny2/eM3/d2JBVziiocUt/WE1hRtM+4gWBD10CJyK+1uXSkiHVH1/732114DtlGfV7lG1ENM5PT
	Ckj+wSU+naY6DmsbRpGCBf1ozokYUcmqIfcVwxoqdlooOz2iL9x9XUtDrYM9XBS/ZH0SOVeh63s
	Mb+G3p7AXPQnI6szPnW/lOJ8+5vyF4F22IVmLGC//jU3pO8ZiiNYZmeS2cXU/Kn18sTCJ+G/QRp
	QjnQN2IiXCtYDkcJzfMDUSTS4s7URxYOaQtobgrnNsElhLG4aXHb4JvhtiX/unQIjAIT1fNV7dP
	hSk41l/KiKVxWXcxPIv/9XV+s1AZdJVbk8VaamgjOywRo/nriQ8Vz0iFpMB9dkVuZceaRU=
X-Received: by 2002:a05:690e:d83:b0:66c:9046:5aa1 with SMTP id 956f58d0204a3-66ccb611d3dmr1019175d50.22.1787121105483;
        Tue, 18 Aug 2026 23:31:45 -0700 (PDT)
Received: from localhost.localdomain ([103.174.171.5])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66ccb1a03c5sm533253d50.20.2026.08.18.23.31.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Aug 2026 23:31:44 -0700 (PDT)
From: James <aslan.jnn@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Raju.Rangoju@amd.com,
	PrashanthKumar.K.R@amd.com,
	netdev@vger.kernel.org,
	Thomas.Lendacky@amd.com
Subject: Re: [PATCH net] net: amd-xgbe: support receiving packets with bad FCS
Date: Wed, 19 Aug 2026 16:31:25 +1000
Message-Id: <20260819063125.19901-1-aslan.jnn@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260817233243.3733000-1-kuba@kernel.org>
References: <20260817233243.3733000-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Aug 17, 2026 at 4:32:43PM -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> This is an AI-generated review of your patch. The human sending this
> email says "If AI is right about other error frame types it may be
> better to program them all in one commit to avoid a behavior change
> if someone needs the other bad frames later"
> ...

Hi Jakub, thanks a lot for your review!

Thank you for catching the possible race between the current feature update
path with the service-work RX re-enable path: `ndo_set_features()` programs
DCRCC before it commits `netdev_features`, while `xgbe_enable_rx()` reads
`netdev_features`. The non-atomic read-modify-write accesses to `MAC_RCR`
also make the final register value unreliable when those paths overlap.
Apologise that I've missed this.

Also taking Simon's earlier input into account, I think the best approach
for now is to set the default DCRCC value to 0, so that this network
controller can become more consistent with most other network controllers
and also with respect to user expectations. In particular, I would not
expect users to receive packets with bad FCS by default.

I will therefore drop the RXALL mechanism altogether for now (the updated,
trimmed down patch, will follow later). We can revisit this later and
implement proper RXALL support (under `net-next`, as Simon mentioned),
potentially including additional features beyond allowing packets with bad
FCS to come in.

Regards,
James
