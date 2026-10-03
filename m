Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EE938F630
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 18:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791051292; cv=none; b=UIkWerAhBg/L1AylazvWbRaTpNhmtAV/pL+dJglRnYrtzeJIL43uVv+Wc4N57Est0eB86GwDWKw26E3ymhrEhA0dZe+pWCa2ryo6irVyrBzDkQ8UdevmXTENoSUlJ3QS5kYvxAIoTIKVTd5VKSChjCT4Y5Uho1sWMvHd10BVwqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791051292; c=relaxed/simple;
	bh=C/O8t+GqZ7uH0tOp1M3kZbpzNeJ5/byOSLujM9tc81E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2h3hY8ml8xFhN/XoiM0oGG2ziwuzxbJouCJxrauBFAIkOh1vpBa9xBKI+DrDIxFw0Lpt0RxVjvBdnlJPHvlnpOBiIKCiNp0RJlvkEa43jG8c5EndrJl9HjhIHBdeHajA3XK/hWiuwxbjxFY2rKHgWFdkOUb0pZ7wbwQ36LwjNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=bHSNecep; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="bHSNecep"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc7901f7971so160515a12.0
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 11:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1791051290; x=1791656090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=utCkglagoBCzPA6FlpIE47a5iNCIZ1mvSU7V9yRQJjE=;
        b=bHSNecepa41MinPRZ31boJXptq5rpVBehgCdoEgsBJTv+FVRwDgHyfwz8nuLHPRw9S
         ysxxoqelNK8JRzu3+BktFViNGBFnwSx4XFhrHDsGMPZsb1XT4DXgApCQzgw6hrCgsou8
         dx/nrV9At4dqGd0UZIEQJYv4xrlbKueqEAYTTjH8QAy+607OGpHNaQHz0p/YDf4ux95Z
         /QViutf0ymo+e/5M923ic4nQKQ0FqBPU0GObD0V5AqfhAXoEmUPz7E81RvNhAwX55Vi6
         sZKDwYDwr/rWJCZh8neb2VZNabzUjOKjX9KeQxB0yteD+oX2thsqCkQd/Fb49RF/nOgh
         UlPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791051290; x=1791656090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=utCkglagoBCzPA6FlpIE47a5iNCIZ1mvSU7V9yRQJjE=;
        b=sn7g9Pv7YIyrKkSUKmgTKOK3Ffw5JVhqPDKQcVb0+6+uV+Nq3eYOJEZKxWyeE1yh+B
         BsSIOTjBosQVxlySO0X3aYwd/Y1biWy+/IFzyBgAdeX6BIirRInGTrsupmZNKvT6ssM9
         R6sbetKECiI9GAEkaPBFc+cI4opRdlaPElgPEsUPbiQ39nasNbRDT48o4/SyG2pzHwrg
         Te9HX9ZQdjLVDIX+DDsCBl8PwoAt3rGohnEIFBAUnwgrOJ+XsNrTtYXNKcWH2GETIzRL
         YCTzZDU7x9z4uCJGhic7Uly8f2MMIT7z2KeOd4ll9MiwO21T21c7TJm9JU8E+J0pav6c
         qiHg==
X-Gm-Message-State: AFq9FYKHvOFHHGDOv++bm8tj9bJQA9IRNAv6T91YlTP2mfdeqTs7TWJy
	Js2NOH44Uk4mBvaszg9reNnKrRTzSOEjLyFfpmnwEgbKIl9g6Y1tKCbfTdf0COCo9r7Baz6wy4q
	i7Xy3yw==
X-Gm-Gg: AYBFou3x8KWFjNnBTc2yp+l4azQ9xUUGLQ5yhDg6Kef+EylwxIacGoyvT1zJpsduUsp
	TqLhRAowLPwoxLShstLTKNk/yaASxW+Rj73rulyHA+n5PpvY1fT8L/E9iM60i/EmE7ZwupH0fX8
	YJuKv1rB9cZtI682fZAoNP5oX98dtuOUS3on5YdmurrykUYhQ4iOThMp4FND4zaTsEkiXWfhUYq
	MJ/xjiTuqVTQvcO5ZgWBhvxmS/iaLKKpIgPGavUxyPoedSkCn26JBCBWZmlshxLY9GXVv48W084
	e4Xy40mv0qtQ0SQS8chBXM7GJRDS2I8oBR21dzkPUkpmSAmfSQE4QE19Wk5eFcLOCRXBZrRQ6iU
	A8DViAwzfrSJblJKcoCwINhrMqCsEUa0RoLHsqC2hebaSdR6/tWXMxNCCsw8x3nup/cbVfRekqw
	Sq4UQPs5Vkj8WZuD0GC+lyB93Sfzf5LWPkktop2dh2GpnwN1W7QEm/IaQlf3CyeYZLHq7L5Ls2+
	kbUHdivFMkP295Wd6o=
X-Received: by 2002:a17:90b:544e:b0:3a4:acde:1e3b with SMTP id 98e67ed59e1d1-3a6ce6e8261mr4321109a91.13.1791051290118;
        Sat, 03 Oct 2026 11:14:50 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([191.222.220.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78daef465sm4000811a91.1.2026.10.03.11.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 11:14:49 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	petalzu987@gmail.com,
	weir@nebusec.ai
Subject: [PATCH net 1/1] net: devlink: fix reload error on netns teardown
Date: Sun,  4 Oct 2026 02:14:42 +0800
Message-ID: <51b31e529d844b075e34a3595ba9b0eb183d325f.1791019703.git.petalzu987@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1791019703.git.petalzu987@gmail.com>
References: <cover.1791019703.git.petalzu987@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zixuan Chai <petalzu987@gmail.com>

When namespace teardown reloads a devlink instance into init_net, a
reload_down() error currently skips the namespace transition bookkeeping.
The devlink then remains registered with a pointer to the namespace being
destroyed, which can be freed before later notifications use it.

If reload_down() fails while the current namespace is dying, move the
devlink to the requested destination namespace before returning the
original error. Keep existing behavior for reload failures in live
namespaces and for reloads that do not change namespaces.

Fixes: 070c63f20f6c ("net: devlink: allow to change namespaces during reload")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Close: https://bugtracker.nebusec.ai/f/11365
Assisted-by: LLM
Signed-off-by: Zixuan Chai <petalzu987@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 net/devlink/dev.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index 55959b0ff5ab..5d201f3d49e4 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -460,8 +460,13 @@ int devlink_reload(struct devlink *devlink, struct net *dest_net,
 	       sizeof(remote_reload_stats));
 
 	err = devlink->ops->reload_down(devlink, !!dest_net, action, limit, extack);
-	if (err)
+	if (err) {
+		curr_net = devlink_net(devlink);
+		if (dest_net && curr_net->is_dying &&
+		    !net_eq(dest_net, curr_net))
+			devlink_reload_netns_change(devlink, curr_net, dest_net);
 		return err;
+	}
 
 	curr_net = devlink_net(devlink);
 	if (dest_net && !net_eq(dest_net, curr_net))
-- 
2.34.1
