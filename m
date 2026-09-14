Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A373B14BB
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 07:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789370499; cv=none; b=QYctlG4sCF00x7MLZbmTgQOD/un8bQj1demtWIBVzzjKf/3e9l7OvzCY9WQT6B5FELeP6CnkKiyWd1ZW9vrBQBwNqAmRbmFswvSeHIqH1I7MFQ2fDA6DeShHkPFJj0608ofcaNPMD+j+LfOvXk8jNcW4P0vJZSqEbYm3CWrA+ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789370499; c=relaxed/simple;
	bh=0h2uF/vIp2VmCWjVzoJJTlLYWilhxHc8CwsVmC+yTKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RFZ3uh3Lq7BafKv55a9fB+zmTKj2RWv/zfaC+IKgU7GOHGeDi1sxAYOGy/Lj7YpsIbEgSfp5Jfq+MDAqPVW42oWCaa/TL/aN+QEzkRmOFoxkP5kDp5TXVF5pe1GGkxf/tkoWbRts1lTj4vh4HlsCAKLsGzmxpLgQNLnq8LQ/t6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GoSj4MYQ; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoSj4MYQ"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7acdc816so748965e9.1
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 00:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789370493; x=1789975293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Acfwk7tNHvsTx4xeegJLr3fmwza1/9++uyWzEXfIn6k=;
        b=GoSj4MYQlYKdWE7SeLKiuZh5jqPIPNlfH7LVcxWqOJNwvNod+yunMGttOQrzZuoMfd
         1AKUmOxfszPz1HEbRqHNfZ/X0qCoqJbhPuF657dE6LHX5jDd87a3qu9en0s3cXDk2g3j
         2+dS+u9BoKVkmCalC2XhpK7A9wRodOAL8pc2sVWMiTd24pSvIUIEyhoE65/o+bnlurZB
         6tojsLBwtKNmeJkar0ucpdBrF8DmV3B8z+uz66eL7nOneoyXkXVaacmUozn9L3tQXhIv
         7g/oJEkjUA9wl4Av2ZFDGnsEVWLTPzKZy3zdWsoXEwRkcFjANZmxPIK0Os4iBZUmHdsj
         Z0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789370493; x=1789975293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Acfwk7tNHvsTx4xeegJLr3fmwza1/9++uyWzEXfIn6k=;
        b=ZtpNo1s0ClR9S2JMXS0UNZBYJewoCZUxtbsOtFhg1AGNIlOUQE7K5YwSn00+5usLF6
         gmr2HA5Ac0f+FwNqYUwTgnBUDZV8iu3WZwy/uGpCSDq6Z9cdoaSeTTlbAVi9ZIJrSvUA
         RmIxFG6S47dj/Ln4zWq6fhMCPo/sY2oJIDZynYpAvfei7YZx4VyWF/juYBqMZAMSSBjN
         7G/nlJBAeb2EZYkcBeHxdxO5Vm2Ygal408NtJhhOfOtpI13Q8OQJ68vmd+cyOUMZKzaK
         inDF1ZfwCvTXAhnr5DucwUmjn5cYHyqqdH7eFfdksQBdtMVCxT31EwhKnSNupMlZCI2M
         YbWQ==
X-Gm-Message-State: AFuF++lCqHaiWXH75wUXEr/JBjTx0m3vzC/jzuO63S3RxC4pl3Njnq6/
	Uj+szJDh8EkKIpXRg1l7XE6WXn32ZjBTCGyo0M78zzaLyPQvB6WGIPxxV7Tx12/r
X-Gm-Gg: AYBFou20ENuZs49daebFoD5Wf+W8JiQZYopipiAd54Ud2/Sar0HoZlHkhmW+YdU3LO+
	l9hHeFLrY3Ma0hewFW6lLtwgL+9e8092u93CkGw02e2wpAEfMG6WcLWvNN6WUq+hNhqevBENopP
	WXTXOhJ0E+rvflcAK6Gx0KuI1q3CmqPnkc73aTwhfzpVmKLUhtzpIB0s+MC+OWD/KZju3djTMSX
	sLIArxqGpQacik/inNAFL00FJSk0HpwYtZVih/Resut60SshKowfzaIJmpptQLOr6f1kgpcOeaE
	PnEpkLX5A+yRjgv3QkfApVxPfrmHlgTdyFwMO/3yGCbWMU3emK+XvUk8fifrnH8vNk3NeEAllvR
	zKx6+NoJfArwt/lcqZjdv8UkseO0SIFcowx1/+/gCDFkDnGp+d04VEAouetwQCO6oxjCtd4ZizA
	LPbYYUg6ZOUhLk07yMF+uOjuYixVymvInFc915pAXeGWVlu7WzVE5NvAwE3IKpbAGrU+jc+8DN/
	YJ4DLqyrxiDQOVc+EDsNcAfNVtOFuqfS9vZHyeO
X-Received: by 2002:a05:600c:3e1b:b0:49e:6836:5386 with SMTP id 5b1f17b1804b1-49e7a5fb97emr14001605e9.0.1789370492805;
        Mon, 14 Sep 2026 00:21:32 -0700 (PDT)
Received: from fedora-tap.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26be3e35sm369476585e9.2.2026.09.14.00.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 00:21:32 -0700 (PDT)
From: Sagi Maimon <maimon.sagi@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Sagi Maimon <maimon.sagi@gmail.com>
Subject: Re: [PATCH net-next v14 0/4] ptp: ocp: add TAP CPLD support for ADVA TimeCard X1
Date: Mon, 14 Sep 2026 10:21:30 +0300
Message-ID: <20260914072130.12579-1-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260914071555.11684-1-maimon.sagi@gmail.com>
References: <20260914071555.11684-1-maimon.sagi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sorry for the noise - this is an accidental duplicate send, 24 seconds
after the original.  Please use the first posting:

https://lore.kernel.org/netdev/20260914071531.11640-1-maimon.sagi@gmail.com/T/#u

The two are identical; only this copy should be dropped.

pw-bot: superseded

Thanks,
Sagi
