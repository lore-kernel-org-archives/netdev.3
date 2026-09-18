Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8A039E6CD
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 02:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789700225; cv=none; b=BUZAtiLSyxw3s3tDQ7Z4ijnCJZK92csREkJTsFceLU+QgnRxRtVSYfRDheZQ5LLB0zbvuUKQHrDvUn/VyxDaIxAQjl9FbIQ74J7Pu1sNtstdjwA2vN2hNat2BI6hOzuJS+8ZMKnaNh+EetfeTQOF+FxV9Cuer3lSuQtHV9dGrNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789700225; c=relaxed/simple;
	bh=WH/rnE12a+uaVlNTry7gwUg4MsviWYt1nqi8WX9vXi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ICwKHDDdIPUs1T8ayM82B3KbfA7014eGhfX8R9Mvjljbpm6kkW/aJxBnjqmPYDUsKUsJbxt5IB1fR1Shnmk81FtREyw/bkgtzd0+4rkRis0cvHj8KsdQ9dGRDrIvImui18pMAV/EymVZ+lICzzQBixKxON8uSFeDpqceAos7pT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clNNZkJG; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clNNZkJG"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747ec6185so1539905ad.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 19:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789700216; x=1790305016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WH/rnE12a+uaVlNTry7gwUg4MsviWYt1nqi8WX9vXi4=;
        b=clNNZkJG562ToNrLE3Cu8NKoJn1kjRqSfvGdob1UUiHd6STXZr07fKOScqWbTRiEjI
         Ehp/KSeIyKyNcJsmKl+x/+kh8BOL644uLZny57bf0uAhnjr7MmT3wvHIY0ODSk1tm7ab
         +haxeFBVHP/+MQR3+7fxX2/JfI5i9OUbtgJl1Z+WCY6UbT+atHc2cg/qaMpRCdfJb0PV
         /HcvpA0ml5TJekYHepfVcZSB6y7MD2F1rEcmI/oI4RINHu1/tH4EBRkxNRK7m3Q4jLkU
         GadmRjScFiTxatV6lzGyP3QGkNaqWALY7Ti2jUbJvaCSuROXrDD2Ii1BYudA4GjTdhTH
         rZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789700216; x=1790305016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WH/rnE12a+uaVlNTry7gwUg4MsviWYt1nqi8WX9vXi4=;
        b=BWUqMl8CTCUfZ/ingOGFmlkhjnUqo+wf/1aE4V+JXkvR+kTg385TFA89bjtLidHtG5
         sGoq0W7VTb+c9V/1cS5JLoTndoqQ1QzQqqclwze7dBNoKWVgktlhLgCrO+1sbr4aPtVY
         uzsmw1u+MLexqmtHbj8aUE9bESisZ5VPaDgLhDIywic81cLeP5+J2JgoafUdZjfZz7Od
         0nTof9o35PkNW5XebIZ+9vqLo1XZ1nw5at4FO3iIB+i6ptOL5UNFEUFP8nkLETJL2YCh
         IuQ2vtWRdNG+CiMvf2blROvZQFcP1JORftcqdCuz4yGUr3/e36KcWoJFP3kg8NFsWU3H
         F3wg==
X-Forwarded-Encrypted: i=1; AKwUvBwbTDMebuPuISH0de9g/CqN75V7/zwjPQGVe2B9n3+SIDC2kzLbXc5UQVP1zUdzGJ7MeRj5xSI=@vger.kernel.org
X-Gm-Message-State: AFuF++mdWrvlPnZsIauuoM4KUbsNY6USppdKWIgRAuUGHNlhiV2zT/Fo
	RP+e89hBlUEeNdIaXCggQVBgnMS/5H7EQGnhR5UMs344bMwdZsInrOuQ
X-Gm-Gg: AYBFou2Jz5a9oI4I2ss2pstlCVGDsvm7ekAKtbvTWS+9oIcYVDLpFINxxmBIrZ2hIPI
	BkvISSKLFrDCtIF5CxKsatXP7q7YhCLa+C5Pvon7tiIdc4LzWq0mZ9Pr00rdNHLDS2JGk8es7oH
	QGLoLUIHeS7S/YjTYBsivHzSHl5G6qaD01D8C4D3x/HWisUUoWbE+o06bZwCi2jGsZ3vypfFndF
	cQMlDuy5z6Zm25ylHPUjNikbme6hHBK8Yeu0dEKXQIjlegG6r/LoM9Thrb5WB6E+xeP4wlpZMT7
	oioWnurP+dD1E+n9XRvMZn8FaD2Quz5hyaGb26sIuo8LYlODsfABXA/fZwTqKs6CTpc+df3kSdk
	zYrgYoQVhEJ3pTa0MFrs/0JcNWhou4e1+56UNVaVgIifjY06ODXan9nXMA5j0AiIfIR3hyhdMmu
	j3/KqE8QJyh5oZ572spL/jI1CY/nE7qh0XYqT8Wq+3aYNRoTiwIFu+rNUf0x+MidDG
X-Received: by 2002:a17:903:2f8f:b0:2dd:ad74:ac32 with SMTP id d9443c01a7336-2ddb1baf0a0mr24255345ad.27.1789700216039;
        Thu, 17 Sep 2026 19:56:56 -0700 (PDT)
Received: from bloom.localdomain ([2604:3d09:178e:e100::c570])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddb75b52e2sm734085ad.60.2026.09.17.19.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 19:56:55 -0700 (PDT)
From: Ivy Lopez <skunkolee@gmail.com>
To: kys@microsoft.com
Cc: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	sgarzare@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-hyperv@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vsock/hv_sock: fix socket/table leak when rescind races the delayed close
Date: Thu, 17 Sep 2026 20:56:50 -0600
Message-ID: <20260918025650.15990-1-skunkolee@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917220213.56102-1-bartlomiej.dmitruk@isec.pl>
References: <20260917220213.56102-1-bartlomiej.dmitruk@isec.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LGTM.

Should this need a Fixes: tag and possibly a Cc: stable@vger.kernel.org?
