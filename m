Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115B519D89E
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 01:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776993704; cv=none; b=uoL3cNPZC8UZEsm+/I7qewlpYqpXV80/4xIQWRYW0bWrU0Q6cDwp46YaTzCTz9Y3b3f06zTIwLL0AN25uyhdIVIMB3VVynmYMfytJeZL0MU+EL7TfbhmZ+RbtyUFA4iFnFBRjBrg8bTQjLB9DhQF0nFc5axGwg0dUQPEZYBi6DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776993704; c=relaxed/simple;
	bh=8AsPe1/CnmmthQk6ZSsNAP7+vFIbShFXKYv/t9fjbys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SrPEhfMMEPEb3eZVsSP2cf9by/d3rMTUtRS5rrUTvtLtYMuZvIYwZb23WuotV+NztrFqbF7WEDYfnk275QTMYRbRFC0YyabyIP9exBjASCmsZOcuYbhLeFJQSr8gNg7egMcoFMIznUJaISdOTVzn7XE4qruvGVcSSFE1PLnSkz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijpf4AxS; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijpf4AxS"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12c8ccc7755so6989162c88.0
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 18:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776993702; x=1777598502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nDev9YNkvZ2QavnSFCr36C5vNn0a8N3LeIk14oGej3s=;
        b=ijpf4AxSKhaGRS2azfnA+b0rrDpFWxb2/AXbA1H2k6sOWbaES3IlOSX2n8l3nRLYJd
         ZadNHZwJa2iS49ioWqUg6d36YyYb989Tq5YwhcMLRhoSty0/icSBSquqSaQbkRPrzjEv
         nE/nyXJTi0NCNzn+fB3ZqAraOs18uaCJDaW/KyvGHD6eMECMnIMbpL0vpQBo/3J3ZSfK
         RXmOMBUdQ4qRZHUfPWKzFlRLYfPzJi3p+TtePLuu5m/OUejgLd9zoAXuMsyT4bIz7Vcc
         OgLBya43xBKDtxZSoIXf3CpcSdxlROS/jj76mRYzmBqyyc3hmFrpxVtsAQmL4eNfecbw
         b/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776993702; x=1777598502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDev9YNkvZ2QavnSFCr36C5vNn0a8N3LeIk14oGej3s=;
        b=ADNnkLSU2JFwSUWKv1Av4t9K3Bo1Zlr7wzN6Q3wRr2nJ5fUGkLTSJkQUjpOZnyOotH
         xieW5P3vajXYkNvZS+oCU9803SxLQ0j5GZwhm7DqF0T7/7zwVnQZHaKfwkRIEQfCtpnz
         mQa56JStCH6Pewizw5qu/1DacfGYi+GaoOO8/i5VlqWUTUhLOaFQ5GRxzzzHgmMK7vNU
         qWxpvjfcyuNrHBPYr1Y93Y2a1p24Dcm1ZT5tIU4NkAHp/I42wjAJPsaOZGafrvZuSGk/
         /9hi/JMz7vmOEjQ+F9QZr3oGlzDzfDoKXho/qGBn0yCARF2ppaZxidpaL4GJKbcETQcj
         XlQg==
X-Forwarded-Encrypted: i=1; AFNElJ81bYopwm7TgIOkPXvR3xJBgxf/JX9LRpSDJ7ShAuJMUpX/UVp6WsuFNw/mRJzDRpgH4jOSILc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwovxyhSUT1y0hEExpLHKnUp/annDIU9M+Ym9V7sPtgmbXTKc5j
	eeaXZFQw+4W8rjA9aYExpZLc8apBeLpDIorySBgjpD0rZJu5eTV5pBVu
X-Gm-Gg: AeBDieuRJpoGkibL+qMnCEAFcc50fyyqmQMaNF8Qm6AVZK1gLFgAXBE7yHTZR+FQI9i
	mG9WMpbyqlWkrIZCRL/D85BYhpzrCYUl4ibnC2sXp8PrRqACoyD0v4WqPWfj/7bIfYU3xlYEzxH
	LHf4bedfXylxxznV9b3xN1GpnaKIhtqu6/XK067ELgo8k289mpY6+WF1po2cA9QJqqqoFkijVa0
	40vSlIazd2WJumkjb9HckStLm3TkXw821rRDJGgyzl6Ed+12pLZB+KSg7ClKXlZ/5pr3j4/UZYM
	2/gFdWoQ4/TiHpF0wroabr8il8PFMFfClTz+5voANVMGvNjTgAR20qdZgL+PhWvSlXMbXbHR5R7
	YcJfZMz5AEy/1JaTHypsIQJocMEuTPho9K/tGACm4XZzg7sHzx3+1tilioblRyVPOL/8gmTargI
	eXbIRS1+GLsOFBQS4cwJE6fD80NG7UBVA1fCcfJif1bk8=
X-Received: by 2002:a05:7022:48a:b0:12b:ebb9:1c0b with SMTP id a92af1059eb24-12c73f9da69mr15819397c88.31.1776993702097;
        Thu, 23 Apr 2026 18:21:42 -0700 (PDT)
Received: from localhost ([179.160.39.77])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-12dbe78e12fsm7589783c88.15.2026.04.23.18.21.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 18:21:41 -0700 (PDT)
From: =?UTF-8?q?=C3=81lvaro=20Costa?= <alvaroc.dev@gmail.com>
To: jiri@resnulli.us
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	=?UTF-8?q?=C3=81lvaro=20Costa?= <alvaroc.dev@gmail.com>
Subject: [PATCH] devlink/param: replace deprecated strcpy() with strscpy()
Date: Thu, 23 Apr 2026 22:20:22 -0300
Message-ID: <20260424012037.89619-1-alvaroc.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace strcpy() call used to extract a string parameter from param_data
with strscpy(). Since strscpy() already performs bounds checking and
ensures the destination string is NUL-terminated, remove the string
length check as well.

Signed-off-by: Álvaro Costa <alvaroc.dev@gmail.com>
---
 net/devlink/param.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/devlink/param.c b/net/devlink/param.c
index cf95268da5b0..26695b7e2861 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -536,11 +536,9 @@ devlink_param_value_get_from_info(const struct devlink_param *param,
 		value->vu64 = nla_get_u64(param_data);
 		break;
 	case DEVLINK_PARAM_TYPE_STRING:
-		len = strnlen(nla_data(param_data), nla_len(param_data));
-		if (len == nla_len(param_data) ||
-		    len >= __DEVLINK_PARAM_MAX_STRING_VALUE)
+		len = strscpy(value->vstr, nla_data(param_data));
+		if (len < 0)
 			return -EINVAL;
-		strcpy(value->vstr, nla_data(param_data));
 		break;
 	case DEVLINK_PARAM_TYPE_BOOL:
 		if (param_data && nla_len(param_data))
-- 
2.53.0

