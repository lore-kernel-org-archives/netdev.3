Received: from mail-lr2-f7.google.com (mail-lr2-f7.google.com [74.125.230.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73D44848B7
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 14:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789742179; cv=none; b=g52136Ss3e4JiFHkLGYQeNPXe7m4A8mQ4KtYtDXlfiWkUJDp/BjI7AecyU1LIMZfzoOtIMBBaKS+PMktiL6/lfMSbWVbhczCgJfocahR/m+x1zQ78CyTwkNDUAdXnSIH/hLnQmVEKoUm6pi6kVGQTdQsMrgrmVKQNVSCf49bPlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789742179; c=relaxed/simple;
	bh=oHK7jTtToiFcxA/9CIKnKR3YjDf4Xd/qP/4WmuFBlso=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YMMbsJ0EVouSa8odQRb3nbRFXRXSzqBofzety5tIIbMmmGGfe4l0FGYPTMpEYi63y/VgrNexbqmXByYnZMIm57dxH8TwXrz8B+VzZCk9jaTYxxKX8tRXmCWBqZ4ahKb5q+bitCRbqL+2tnJmV8qeQF811HVs1qBtncQmnARobOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q6GZOzx+; arc=none smtp.client-ip=74.125.230.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q6GZOzx+"
Received: by mail-lr2-f7.google.com with SMTP id 38308e7fff4ca-3a5abfab93bso5181401fa.1
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 07:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789742174; x=1790346974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=80thoqF6oWnfHU18nXpOy6DAO7B/ZBVuVLAIvy3f1Nk=;
        b=q6GZOzx+hzy2iRbWqUtd613E/F1RSqTkZy6oNpOtQiM22AldCxh7HS9KPHKzTq1dRn
         UPzCjtFO08wT2CY5eorcv/MRk7YDYX8yOi0qrltD/rGX31xNJacSz9UpTAraXANOUfBY
         zG+xBKDt4H/ok9tA3pJJHHPEkHGvLuuZcMlPgkEclOUph9KLFyRIXLaB75OxKiGPkVRM
         8FcNxB1I5WAt8C/vnCnrP2geeNujKK2WMoRIIkPOouSDvf4zIenD3BB49KIv9WREDHOn
         7fTSe7rZSeyhnq+Scx/a/NcFr8coe9JvsoXD9HOtOD976pxEL+zCo5F9xXPaNIS1BYX8
         G29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789742174; x=1790346974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=80thoqF6oWnfHU18nXpOy6DAO7B/ZBVuVLAIvy3f1Nk=;
        b=RUO252P0g14dtq5qkK01NuUJtNedcOoE5S6WVxoIYs+ny5erpNGrCn7PkEGWcjJD/W
         i7ej2aWSYWyiWcT5h93t3tplCi5Vf9t4tn756x1WaM/57tyDwGPHglX8xWklPZvQVKpd
         GipMlOeBhYlqov7e8dNP0sXSU0r2YbE2cMy6KtU3+9SclCkP/FUheIESmVkfhM53EpF2
         Uuh32Qaludsp2t4MF4omUcBXOZL3E9rl6CDDLR7ctYyZmhR/rSG9/I0kZ7w2dWq+1vTY
         t1UUwl2DxkO6H9El7Y+xdQ/p0Uq1Tji83+hxMvupUqRTbwxGDjLKleOP1VExmMbD36kc
         LqkQ==
X-Forwarded-Encrypted: i=1; AKwUvBzWqURozbpEnJAjeyXi5iTYUJF+xz4sYiyLlb50j9/jpcsUMjucGiEAHBfpvW/KfKAwLfY28nI=@vger.kernel.org
X-Gm-Message-State: AFuF++mBYxu/q70zq/bCGZ/qMcy2d62gZ9PBPxCABnYcYkLfLxRlQL1x
	KOm3PAKUKNGg+I6CDKxAubqwQxaKyBdP8dLhMOdO3HNZbUb2u7RzT7Ks
X-Gm-Gg: AYBFou3z52B3gba3UkZUZ2biD4uYSW9ay9A2WH5UVaSOZRpxkGLZ8McbulZZbwuOj5P
	84J9kb6t0599HOo7BYp0iMpqcUDbPqUKC6qHtHF3FhEFzohhht5gDyFWpUbfIR+x9qRYr+osQNA
	fKpzb5mrISIRblV8c+AHcmocdnTnTIvaBhGfX9srFyfvIpwz8rGR7CrAWGgk8c91t/ujdfK8Xtl
	5BS0/Be/YqxKDnWlaDJILuzfdBtOnHvemrBQ652ArfuIuA3enzdFTNqEcpIuBgTeE2UhT++b8wy
	jejPu6MOQRNmlBm8rlYvO9H2YOlQaUX7GZRvqm0fIjsgzoW3GmEQ5ql+mFLE5SKlnPThYU1AxnZ
	EfUI5ynYkxz4kSIZF8NWNzDA9mSd4k6Cm3sBmKwD8q9/2vO6Ql2gxAc3BNkoZkR8Hkc7bNqeyND
	vAJ+M9wrJNqTORsHT1ZuTkvFWSAMcTE7YXnE3Nhe9gZMMUQZdKaqXwR3MlnzfYwsbk4CezaDaj5
	3cWlA==
X-Received: by 2002:a05:651c:150b:b0:3a3:749e:319b with SMTP id 38308e7fff4ca-3a5fbf55489mr5837501fa.15.1789742173556;
        Fri, 18 Sep 2026 07:36:13 -0700 (PDT)
Received: from linux ([78.40.184.2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a5fd80eb8csm4784691fa.21.2026.09.18.07.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 07:36:13 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
	Kalle Valo <kvalo@codeaurora.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	"John W. Linville" <linville@tuxdriver.com>,
	Eugene Krasnikov <k.eugene.e@gmail.com>,
	wcn36xx@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Tristan Madani <tristan@talencesecurity.com>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15] wifi: wcn36xx: fix heap overflow from oversized firmware HAL response
Date: Fri, 18 Sep 2026 17:35:31 +0300
Message-ID: <20260918143539.97842-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

commit 88a240d86d3d64521f9194abe185ac71cc74d0bd upstream.

The firmware response dispatcher copies all synchronous HAL responses
into the 4096-byte hal_buf without validating the response length. A
response exceeding WCN36XX_HAL_BUF_SIZE causes a heap buffer overflow
with firmware-controlled content.

Add a bounds check on the response length.

Fixes: 8e84c2582169 ("wcn36xx: mac80211 driver for Qualcomm WCN3660/WCN3680 hardware")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Link: https://patch.msgid.link/20260421135018.352774-2-tristmd@gmail.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2026-74341

 drivers/net/wireless/ath/wcn36xx/smd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index a778e3e0599e..6ab91ff8338c 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -3174,6 +3174,10 @@ int wcn36xx_smd_rsp_process(struct rpmsg_device *rpdev,
 	case WCN36XX_HAL_GTK_OFFLOAD_GETINFO_RSP:
 	case WCN36XX_HAL_HOST_RESUME_RSP:
 	case WCN36XX_HAL_UPDATE_CHANNEL_LIST_RSP:
+		if (len > WCN36XX_HAL_BUF_SIZE) {
+			wcn36xx_warn("HAL response too large: %d\n", len);
+			break;
+		}
 		memcpy(wcn->hal_buf, buf, len);
 		wcn->hal_rsp_len = len;
 		complete(&wcn->hal_rsp_compl);
-- 
2.53.0

