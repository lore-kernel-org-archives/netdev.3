Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320284A21
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 01:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789350355; cv=none; b=MNf7pkuLCoG+zbE7DdyZ4ifd8Aji8998Ichc/Ot0vxpF8hVZZpXdZDFpSmutn0vzorv2ofKIiUCL9HaYbphlHGOxMIlaCebhYsqmeKwb23ZhNmtODh2w1MnOX5wUL+wJKKfxjAHaK2FDo34cfhs+rbOK4spUJKM2DrRO/RSMHnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789350355; c=relaxed/simple;
	bh=J8Mf3HYZaTmZYQFkYELALEytTws8uvz/goY09yFk2pM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NVj5vX6b2zZsgkAbysV3ncj9kmZm39/TpOfOTaOE9phe25R6WqRqWn7gdMMMGKQAvh5vZSxeZbwaa+EqfuFBNwy71j1NeQPOcyUTyMqKSw04Nej2Dq+aVUp6PbNJjX/MzsSkkP9mM8rLd2X2j4BTSmMGMtRkh++ljIS8/wcYvC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oPmbjGvj; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oPmbjGvj"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b31b4281eso1642852a91.2
        for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 18:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789350353; x=1789955153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pGK4SZ365cD9EYRGUuPJEEEIN0V6+rF/hbiJa0/JQok=;
        b=oPmbjGvjZIWSY1Y8ESOZjbNHZG3ihC8JLqbxdeKQSgUhFu1ip3egUqTHrpyK2tLMiZ
         q5tZgNqSCrep2s/AvAzPapmIkLFAE0YUgym89hpZDewRku7fjv8pOnre5rO9klkfD2dm
         cVsGvaDxT+RjNqAW+vyFf8L9+lDn+DRXVVB5JWnxUQM/gzFurz85WzGdPjm34p6cOSyt
         cNd+ywHMzoYLqalMyvrB3JLi12QRaC3EwKXSGkqe7KpIVu9zO6tF5Lzn88g2xHXTKH9S
         CfJ8K6tyOuk3j1x/yGdv6Ow4cVK5A3xof+0JV3qKTPkOKSAShsKLj01M2MY6yZ1nVzK0
         U1/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789350353; x=1789955153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pGK4SZ365cD9EYRGUuPJEEEIN0V6+rF/hbiJa0/JQok=;
        b=AR44QQjgJ/DgoGINkhnKabnPxybXu+aQ2xlSLGb5ZaRAOwdpMgDL9Yb7AuLltdA0Ol
         bg+zXlgjlIYk424UCdOeWhgO+qFWfBX1XM/iABcw1HY9OX1jEkuWs8OvD7i6ObZ8CWac
         pXDGI8S9kY4PDUgRparDNWOxUZwMGQt0VP9Emr9Do5zEoP5pn0VIurrrbO4Jia7QmuGs
         DfQb/IIX9AWHVOcMHZBaFtreJcz3exgHycRNcu8T1NLzs5vi1Div9Ou65tdCJlxvrYt/
         MUnkr2C1jadJGedT7PSzYf8+B/k9nq123M2SZpH5h57rwHyMyIsWyFc+/sb4ksHdCqyr
         2C5Q==
X-Forwarded-Encrypted: i=1; AKwUvBzWnQXB7+Vfz+GjS1/WtIZ2MponLgssedIIrOAmI07vcvauJqz1rjSonz4TI1xIF+Xfbgoxvyc=@vger.kernel.org
X-Gm-Message-State: AFuF++muF+T/FSdVylyXsu55vvvO6msNy+u/MDTLG7CJpKkfiKvsjwJ+
	Uh9Pm6IXG9ESzgxnc07oBhnSKgxdYvOmSqm0AYMKtYTpoD6SbsJUph8W
X-Gm-Gg: AYBFou0ItQRQ00p8gzJU9yHmLqzWio67LjAgRdLqZCbKll/yU7qnJqttwfwGFXa3/nT
	WfRUCdCYLxRWtTbK+UunR9dNPtLvDLWMNAmRKq8B9SELde6saYHUQAegK2Rxac0MwUsCm+QhLLT
	SZIGWFOiwXmOcWQWTxrXSkfagwKruC9Z2mDrhp4tEPVGxm8X5CIsRpypWClEVMGEM2+sE+SApeX
	kJyEgSxJgP8wDzsm4JoMp0BfGn4usRx0qqij92+hl+q5mhC0206dW2j34ehWMmP1nRvubbLDMWy
	BSESDuEBR9bF7LNQFlmr1nCkJZcF78YaCJkStEWugmaQY001doby3saOkLS0JEkLoDdOIG1ck2j
	xHcbiCczdhPhd54He5Fh3aKWBCb40NnPgLb97RwV1bXHnI+bjlc+H7hIqTuPwKGnmHPzRf+c0Pf
	04XRwVXDyelbicXwXM6owO1q7Q6sOxyBnPq454Pgye5xa9XNrNLcUpUqQLJrULZgpurK3HC0gU2
	hVWmDc8mPhsAl0akwSyOagttriLc0IOtSRQM1fHt3QO9Cg=
X-Received: by 2002:a17:90b:5343:b0:381:a766:efcb with SMTP id 98e67ed59e1d1-39debf6b420mr1107499a91.4.1789350353561;
        Sun, 13 Sep 2026 18:45:53 -0700 (PDT)
Received: from m-upc-A520M-HDV.lan ([2400:2410:3f60:500:fd07:4a24:951e:c85])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d951d1056sm17513403a91.7.2026.09.13.18.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 18:45:52 -0700 (PDT)
Sender: Yuyang Huang <uyoko90@gmail.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Nikolaos Gkarlis <nickgarlis@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v5 1/4] netlink: specs: rt-addr: fix the type of target-netnsid
Date: Mon, 14 Sep 2026 10:45:36 +0900
Message-ID: <20260914014539.5015-2-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914014539.5015-1-sigefriedhyy@gmail.com>
References: <20260914014539.5015-1-sigefriedhyy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel parses IFA_TARGET_NETNSID as NLA_S32 and rt-link.yaml
declares its target-netnsid as s32, but rt-addr.yaml has it as binary.

Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 Documentation/netlink/specs/rt-addr.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/rt-addr.yaml b/Documentation/netlink/specs/rt-addr.yaml
index 0ecbd24c890c..17ead2203451 100644
--- a/Documentation/netlink/specs/rt-addr.yaml
+++ b/Documentation/netlink/specs/rt-addr.yaml
@@ -119,7 +119,7 @@ attribute-sets:
         type: u32
       -
         name: target-netnsid
-        type: binary
+        type: s32
       -
         name: proto
         type: u8
-- 
2.43.0

