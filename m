Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF2A3A1A54
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 09:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788343198; cv=none; b=Qh+GrY2jT1LDxypmuTotLF0N2WsnXVwsQA2Vm7Xh5uRsS89UWpPvE2xdQY6Q9D7Bhrz7/uUJlhwAcCBkKa9ahZdvhvvfYwma/1NFDeKfH9Hsw9e1h//Cx33+s5Nch1SWUclnp9QPfnF9zqjMJVCewbZRJL0PPnUvwIW+khIppEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788343198; c=relaxed/simple;
	bh=I40ty9yglW6ETiDTNrAhmrRoixlM5bIx3S9RD4G6+Iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nH6yUxpBvutUPJfWAd4e3vQxEIBjcsacooAQussfVP7Co0M6DgsllLUPG3A6FFLeg+qpIIrxB6wRi81mLRSXF7070qzMgLRVlchy2k5cs4xjK37ph5nZzsbtgsYzIbQwRPVDAJA4Kn9rz8JOEGacUqSbYr70QpgR/zHhbzs/7Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n+x7Zp22; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n+x7Zp22"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-484361a8e38so120204f8f.2
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 02:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788343195; x=1788947995; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I40ty9yglW6ETiDTNrAhmrRoixlM5bIx3S9RD4G6+Iw=;
        b=n+x7Zp229ip0n0Y68GUjj9CZHciOtj3M7J10Yw1lRJuUg+N7NSf9ENh4aI42vs49jA
         on31SwW6mEL7qt8nL0T5bhF68IZofqnJ1s27DKYhmzer3rddcP7zTuFW6H12/9G3E9+C
         s6yq+1QlpKzTD3Zirgith1h/jtuzP4X4If8XM2L/l11sz/IhfGpemfGtka3+hJlNRTTX
         okA9wb4/tAe95M5zVuReEPelqmimJB9trpQ/ob0wANz7R8WvGIJD0VbP0IqeL+PIsJDz
         kr+RVhRvROaQr9HqGB6Cr+0kCqFjA0IM8IwpCeh7qpkYtkesGGIr2vFiSuniXi4CCta0
         8ABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788343195; x=1788947995;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I40ty9yglW6ETiDTNrAhmrRoixlM5bIx3S9RD4G6+Iw=;
        b=OW+kVqsA9qLrC/qRDwyJX2A1LtR7cosHNq/F/j6D0GxbLi1g8GDQRI8mo0FIVGmB6l
         crS8cypWyO7CJQudH/ciDkE6GuxceIgXHb5AhR57nZkxGMQ9VtVZaiF/fFyhm6lsAqYs
         whjA2+k5y9VZjsOxqwbcV7r9AQHOUQF5dOzWNet6X8lOmFdww9wkR39DhYLHJBjYufj9
         hAb3Syx+2Kluc9rECmD6QukkF5FIGd+gCE15uSjGHp7VVvgYC3uwmgoxXsmaRii89ERD
         lTGedQIZPi9Chop+AR45M92b1Lyrwe7ZCuB/olA9vPfaDExqEiWb+jKMBx2FEBdN64T5
         B+rQ==
X-Gm-Message-State: AFuF++leveeaYB0Sja7dgJa+V1zYJg6dwuUaTTnhaEUjPxckxzWFXsbp
	H5Y51Lwk0Sc0/9k0Z81jbX4VArRViveXsZfAVoE0zL1rWdHxIUSvG3CG
X-Gm-Gg: AYBFou2O75InaAsAtX6znd4aXFkvXzrhtYJCDCwpb3a006WIdWZU++U/dfVfco9bio0
	SJdzwFYDBRHXDkzHgUO+TRpRxYEvX5trWHq0WBd+DauVWAc9pKH7KidE4HiMTfQlF7i1PbJcoR2
	fNjBNiaZcf9Jux8t0Yn9k88XcW7y3GFJcE84zP8fsZUWzDAfm594gxerkA0hd7YaIQlksste4qT
	6IJ7vlbnTDgGUuLiaQMhdEKXFVpNErDMPbQi7Axify1rvbIBoNLo7c445d6P3Mwz6OQNSa9v5CQ
	c7sMTF7Lg3A8cs4Byo39PyCrf3UYvpsW89+LCENLJpj/YKc0F/YF1x+d28NVDM3yqFKTGaWtA28
	PKXd3IZZIZnBTp+Eij/zQwI9gfdv+AsZdDLt1wEdg5qiTmXYFoRJAM3U22fXZ6qNL0n7aC0NFMU
	tzO0BvrLiye9U/bJ1m8XUqs5IzVEUYPykSogIzMFsodOqUO9Ev08tV0M9KyQAVID6XoPs/dJzXL
	w3bykMo5a64SBTq33Y6rT2XrNaCE4ElIWVjTT1tZcRjzaSlRIYcQRSHQ4y924QDwcD/nE87377x
	wOIm5ofcJzibAmmgeGzCi08=
X-Received: by 2002:a05:6000:2903:b0:484:3313:a046 with SMTP id ffacd0b85a97d-484914f1683mr3231063f8f.6.1788343195303;
        Wed, 02 Sep 2026 02:59:55 -0700 (PDT)
Received: from [192.168.1.144] (98.102.222.87.dynamic.jazztel.es. [87.222.102.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448e736a6sm5127715f8f.5.2026.09.02.02.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 02:59:54 -0700 (PDT)
From: Miguel Garcia <miguelgarciaroman8@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, jacob.e.keller@intel.com,
 syzbot+372a7d84708b07f64d9b@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Subject:
 Re: [PATCH net v3] devlink: use direct firmware requests for flash updates
Date: Wed, 02 Sep 2026 11:59:53 +0200
Message-ID: <178834319365.3590598.1559493927150458484@gmail.com>
In-Reply-To: <46ae913f-39e8-4041-b15a-8e7363cd2fd4@lunn.ch>
References: <20260830111700.1799255-1-miguelgarciaroman8@gmail.com>
 <20260901123819.2035064-1-miguelgarciaroman8@gmail.com>
 <46ae913f-39e8-4041-b15a-8e7363cd2fd4@lunn.ch>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thanks, I've resent v4 as a new thread.
