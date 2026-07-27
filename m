Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E843E433023
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 18:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785176349; cv=none; b=ZQ6Qc9q4WfBmYqMZ6RsIy5a5w1JAZL7d/uMFsqDw/ugRvg8gutgYIRBtTPYN38rBDvvPHwuAKLzab8/PZ2kDrerSNK1vnTI0ARC99olZKk9C7QKJZrk4eQhUC+edc3BQw0x2Ou3XDLfkvSJ/e6Oe3c3otzpWb69ydZ0PjHlOuo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785176349; c=relaxed/simple;
	bh=LCFB12z6scQ+ae2dL7dad5g7aifAW8FuFUG06zQCfWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RPszabNqO78S/ZKLnBHJFemtyiAZQe85ddIu4u7IYcxXYX/cmR3nbEvfyGLtWDkDiYYNuKtfgMtgj/1Cs1/1REVH5MVtWGLAEStTtDAPPu3fhNx+59Wi2sl7hxpYtYxh57UFwEhpFSJZDxwt94hzKZeJm8Mbj1m7I5a7BP5aHYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-4758bd3731bso168860f8f.0
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 11:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785176346; x=1785781146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4fi0WlZV11A3w9tLPVBtDdauyjxFE6/gukfGCcACwmM=;
        b=WO6KFODJqVV7CZ2nS5RHXJiApGSw5KTOLAguoVMVarbbiaWgsFDPN8IfQJM461A55h
         XiJROIrlMrZ1EgdJJcGU/3Bffdkqs8a/fAg3nYPKy1Cbe8Lo8+XEdpBYV496WtZgAH/f
         wVLfbjVErIe6hLnHC3tESQYsuqz7TCSFngpMfotVTkdRswRVc5+J3Am9Kim1nltB+6gt
         9DayxhZ7yTDZAO6bTbjNUmUQfMg+VqlsPLYK8KceqLVVCjIsEvy4FiRxNMx0tpikwWSY
         MPEcyWR4Tf/n9X1DZMWy7V81lVQ/aYGEHEDSPZJZEqrEzzsE6dYhJuLr3A2vTyKSmTAa
         GMxw==
X-Gm-Message-State: AOJu0YzwA/2ejt9o472HtmUoB1nAsd0N+sqOhb4QI0JZb3pl5soPxZTc
	iWs0crxWue10JnitANIReZkwvGKt/AQKAJz3HcCTAvbAqJNbZ5UXf5eAH09c/pY9
X-Gm-Gg: AR+sD10G1CxGgbEWeWXHms7cS0RG8d49qfb7gUIUFHtwdX2oH9z/NKZockTvHaxAb9+
	NjYb/BMQaX7AkwXLznYVGZcqGKQNSGg6z2nHeogZCaHPW797Y3WN2WbPxfisWTgl0oSRk1JChIX
	l24tjDwGtHqWlZHzCeqXHol19Ax5LhMAv5o9DLA819Gfx318qH5KG4OzEBd5g4cV5sVsKekFRrk
	EMzNCyiIwCo/5ok4fgkR50SeuMk33B70H3GChgeHEuJLe8wExEZ2zrH/qoC3VFch2117nAReaCA
	67rgLmiS2inzLfY5D7EnyOcZvuBJBU6PHTqqNfJcRZcwYDBHsZzeJjClH0GIrtJFcNt3AvgRKTb
	srpV97QUvquzKwUOiT07//NbjGhY1ljrjNJTI98P3d4oqJtSXs4r0AgOHJN29mPyjkwuiGC+TK8
	leInH383TMVakPr865LzcuR2UrOHg/z+sHzfIJ0GDAwyw=
X-Received: by 2002:a05:6000:2c0f:b0:47f:9275:b20b with SMTP id ffacd0b85a97d-47faf5b4abcmr684092f8f.26.1785176346147;
        Mon, 27 Jul 2026 11:19:06 -0700 (PDT)
Received: from im-t490s.redhat.com (78-80-108-129.customers.tmcz.cz. [78.80.108.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c52fc0sm51042855f8f.23.2026.07.27.11.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 11:19:05 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org,
	Ilya Maximets <i.maximets@ovn.org>,
	stable@vger.kernel.org
Subject: [PATCH net 1/2] net: openvswitch: fix skb leak on flow key update failure during recirculation
Date: Mon, 27 Jul 2026 20:18:30 +0200
Message-ID: <20260727181851.306076-2-i.maximets@ovn.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260727181851.306076-1-i.maximets@ovn.org>
References: <20260727181851.306076-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

do_execute_actions() returns right away when execute_recirc() fails on
the last action as it assumes this function always takes ownership of
the skb when 'last' is true.  But when the flow key update fails, the
function doesn't free the skb and it ends up leaked.

This is a very unlikely scenario as it requires the packet to become
unparseable by applying a set of actions on a previously parseable skb,
but should be fixed nevertheless.

Reported by Sashiko.

Fixes: 971427f353f3 ("openvswitch: Add recirc and hash action.")
Cc: stable@vger.kernel.org
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/openvswitch/actions.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 513fca6a8e8a..5653b6642e10 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -1108,6 +1108,10 @@ static int execute_masked_set_action(struct sk_buff *skb,
 	return err;
 }
 
+/* When 'last' is true, recirc() should always consume the 'skb'.
+ * Otherwise, recirc() should keep 'skb' intact regardless what
+ * actions are executed on recirculation.
+ */
 static int execute_recirc(struct datapath *dp, struct sk_buff *skb,
 			  struct sw_flow_key *key,
 			  const struct nlattr *a, bool last)
@@ -1118,8 +1122,12 @@ static int execute_recirc(struct datapath *dp, struct sk_buff *skb,
 		int err;
 
 		err = ovs_flow_key_update(skb, key);
-		if (err)
+		if (err) {
+			if (last)
+				ovs_kfree_skb_reason(skb,
+						     OVS_DROP_ACTION_ERROR);
 			return err;
+		}
 	}
 	BUG_ON(!is_flow_key_valid(key));
 
-- 
2.55.0

