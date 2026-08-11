Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C183F403AFA
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 16:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786464991; cv=none; b=Ke9i48S6fYFd/hyzQc/WyhljyHhKCsLnedZDNB8ie8bOup1mq2Cdd26ChEWPhoJmzmycSthbAFIrcqmUIeXfmmUTlowGQ31sV3pykOGAFJcP3w8A5BYSneO4NnxF8ie7IBzMQZC3HDckHk2BTAkczHRnikIDDHk+dCLebDDH9QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786464991; c=relaxed/simple;
	bh=rL+1cscBL7DruRZtVhJ1GMBcU3y4ACC4gyo40QpBBnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k889iuu2pQtZ9ZymxqAooyJ6SwY3/C+NekjsUIVHJ6SsjCFwMnVS3QZapqE+GDvx54oTejLcuCD4LqGtgLPpcwjjOFCOpX03PzjWnvQ62yJs3b6HFUDFegu7kf8g/U6lLEW3eh5Ojg6QxfYf9zDbQHR2tLT8oOqjTmTktkg5tgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvwh+g14; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvwh+g14"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5b2aa3be376so17238e87.0
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 09:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786464988; x=1787069788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rL+1cscBL7DruRZtVhJ1GMBcU3y4ACC4gyo40QpBBnY=;
        b=mvwh+g14fs2q58w2Du3RWgzTHRp+cVzb83gaJ06mI40CJ3t0gqHArrdBzVBibZwGDs
         VtLLW/aePQRY8Bbm3ckCxFixgGLYzHI7QQ0M3PXSOMiE1dscod63VttfcLNDzntSc/wd
         EZtFihlG4nhJJEEM61mFaDHf/6uXJue2+nb0eXL7hBgVXhliKC/nsEtyz8ygSvGIsaS/
         auwh5EQCzK6Obt4ZyMGbFmqkTdKoDxChRrKC8QRL1/eDPpA9/rbL98kz8GfQ98gOxOtC
         xxXOiEbImfRCPk8IkIs9s8ZJR4tzvLnPYZU9YF2t+19QFWSlCeLkkmJKBi77dY4N89yL
         uCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786464988; x=1787069788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rL+1cscBL7DruRZtVhJ1GMBcU3y4ACC4gyo40QpBBnY=;
        b=jpG8DpEgbw22PulXaX6AlldZf4R09NAJb6EOA59v+qYHFqzI8oGFXxUtUKStugId+D
         0bnz8wF91ugMCrB8jV4aW3UyzeAgdXJ+B3V1PPpkZPdCSxhfG+3ZscHPTisVZ9mk+AqH
         UhyIRFDU4LYunLv+WIqkNTQzPH6qglErKfVvr5NOTG3a3J9z1LfuH9TQWfdQ4KnFUQHN
         9APD5lF+I0kjAZqCnwCB0PuX2j1F/4FQFpnqbNcAPIXbHaYOiOMl896eoLev4HhwHzGj
         SUkMf2myzmJwXgaN1oGbxoukkSoT3g3FyjIKB4O/wkhedTAESmxdUvzYCca0ZZFLpFae
         wFsQ==
X-Forwarded-Encrypted: i=1; AHgh+RrQDbOvBsjLkptXsVtnYArfDKRkyVU5Cvzywr8vk5XQL9N09BKSdGCnxfoSqlLBSmiY/acZp9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYUr2waQE9+UO0Y7gF8/AjHJfnxDr+pRUgcqcgi88HtMnqmepH
	BQVXcWmISidPaOXIv6n1DuYo014s5CfgPDqV2kwWKVn3Dk2d1cvvOQw=
X-Gm-Gg: AR+sD13xqJJPaIPZMrthOMkg+fO8id0K1j3uSOltVjsvo5/SMvKFAIyqgWjGjFovpmB
	3qQBdtBDLVGewtNBOkwD5OrmIokTDK2hJihJCUGW0DNp2xifhNGAr/g/l4c5lDsF+Jfs5JvEdmS
	rTm4xcc5zmPw24seR/Vzo2nXTfcCW4i0G6RMGWfwcZkEFGh8DbG2FmveENZyrgbz+flvS1zhKag
	lhZ77H0TL2ojijbl56iER5SRi4+HjN+1rs5WOK7CwQx8Dr7ByttDzajWMzDUggrTi/EzLyYAd10
	WIaT1/g+U7t/I0CKMx+UX/d/fA1UqNUGiiSDkTMWNfS04uBQNQKQcCYaeVbMGzMVmnHziGfR0rt
	FArhdexscBNhz/THhISLjsYVrAkeSucqEkr1EUEeOxd7B6Gi70p5mwWyYBaV0ZsrmUiduZlTqNI
	eM81QBkFxvBq5Uje0z3ob+a5C0nsGjp35KnpZsNTQH1NxXnGUYk1I=
X-Received: by 2002:a05:6512:3e28:b0:5b0:1f06:f204 with SMTP id 2adb3069b0e04-5b448649364mr752550e87.34.1786464987550;
        Tue, 11 Aug 2026 09:16:27 -0700 (PDT)
Received: from fedora ([46.8.219.5])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b4486cacbbsm377769e87.31.2026.08.11.09.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 09:16:27 -0700 (PDT)
From: Vitaliy Sochnev <sochnev.v.74@gmail.com>
To: pabeni@redhat.com,
	lorenzo@kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net] net: airoha: npu: load the firmware without the sysfs fallback
Date: Tue, 11 Aug 2026 19:16:13 +0100
Message-ID: <20260811181613.19199-1-sochnev.v.74@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811110253.181862-1-pabeni@redhat.com>
References: <20260811110253.181862-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both findings look right, thanks - v2 addresses them in the code rather
than only in the changelog.

main-1-0, the lost warning: confirmed. request_firmware_direct() sets
FW_OPT_NO_WARN, and the driver did not compensate. airoha_npu_load_firmware()
returned the code silently and airoha_npu_probe() reported a generic
"failed to run npu firmware" through dev_err_probe(), which at
-EPROBE_DEFER only stores the string as the deferred-probe reason. So the
file name reached neither the log nor the "deferred probe pending" line.

This is not hypothetical: I hit it myself building an AN7583 image that
shipped the en7581 firmware set but not an7583_npu_rv32.bin. The pending
message named nothing, and it cost me a rebuild to work out what was
missing.

Since the regression would be introduced by this patch, and the patch
carries Cc: stable, I did not want to leave it to a follow-up that stable
might not pick up. v2 reports the failure from airoha_npu_load_firmware()
through dev_err_probe() with the file name, so it lands in the deferred
probe reason and the timeout line names it. The generic report in
airoha_npu_probe() goes, since it would overwrite that reason; of the
paths it covered, devm_ioremap_resource() reports itself and the
malformed firmware-name property now does too.

main-1-1, the usermode helper: also correct, and my wording was too
narrow. "the patch does not disable it, it only keeps the driver from
falling into it" holds for the mechanism in general but not for this
driver's requests, which lose the helper route entirely, including where
it is the only one. v2 states that as a deliberate trade-off: the -ENOENT
to -EPROBE_DEFER mapping was written to wait for a filesystem, and the
sysfs helper interface has had no in-tree consumer since udev dropped
firmware loading.

v2 shortly, as a separate thread.

Thanks,
Vitaliy
