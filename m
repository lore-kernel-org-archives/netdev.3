Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2938A43DA4C
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 12:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780575601; cv=none; b=fG0ZIeUiwKmG5168KsJsglLmJCKMhG7ahmYvYkpXx3EcWt4j/SIYzJME1djjtZELTMrDB9DipuYn6IhNUoGE3LH5hiACbEy2kyeSiEwf9zkcTa4rknmGEbr60O79sQ2TECfKA9FFpcfYQ8TtZ1LUUf1kq1DxTK+PbXLLz+yg2lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780575601; c=relaxed/simple;
	bh=SI0wUmmssdNyLig00onMvpbP/Rf7xOYdVtG8qWFPk8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uZslyR6swXZilN61Ot0zUzSBK0keVP3NXReRgGi3v5+tNXV0DgoozwGQwiE/SCEUkZvaUAua7NDHyRR0IvGpwjKEPYQaQhAX1GQJN79PsmPBiFPIAF+UVUJ8/O38U6sNCFDgBYgfBHn9vDHcXxL1T8Ek9pzpq8g/4IWBHjJp2oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eX1TVbd9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eX1TVbd9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780575598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rQk73RjGmv1YYZSKsEIY/tBeBU1Z6whR3boOZNNywYE=;
	b=eX1TVbd9gGSMoiyEKb3Cw0mc2Yy7GlQ1tTArRwmxpZ9dBkza855f77m9C0qXGX4559RoGk
	MYV+2O66IZ9zTOMPw8DaA2Fx2qEzuAwT/YDKcrUMPBieFmhTifvSAr7Bo7mX/6Z4wOlVGV
	qXy/4ICB//ELru8Y6ICheb8w/kqskpY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-V6AZ3xNrNeeUPKgNMdDDkw-1; Thu,
 04 Jun 2026 08:19:55 -0400
X-MC-Unique: V6AZ3xNrNeeUPKgNMdDDkw-1
X-Mimecast-MFC-AGG-ID: V6AZ3xNrNeeUPKgNMdDDkw_1780575593
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 59AAF1956052;
	Thu,  4 Jun 2026 12:19:53 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.44.32.149])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A1D411955BC1;
	Thu,  4 Jun 2026 12:19:48 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: Adrian Moreno <amorenoz@redhat.com>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pravin B Shelar <pshelar@nicira.com>,
	Jarno Rajahalme <jrajahalme@nicira.com>,
	dev@openvswitch.org (open list:OPENVSWITCH),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: openvswitch: fix possible kfree_skb of ERR_PTR
Date: Thu,  4 Jun 2026 14:19:46 +0200
Message-ID: <20260604121946.942164-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

After the patch in the "Fixes" tag, the allocation of the "reply" skb
can happen either before or after locking the ovs_mutex.

However, error cleanups still follow the classical reversed order,
assuming "reply" is allocated before locking: it is freed after unlocking.

If "reply" allocation happens after locking the mutex and it fails,
"reply" is left with an ERR_PTR, and execution jumps to the correspondent
cleanup stage which will try to free an invalid pointer.

Fix this by setting the pointer to NULL after having saved its error
value.

Fixes: 893f139b9a6c ("openvswitch: Minimize ovs_flow_cmd_new|set critical sections.")

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 net/openvswitch/datapath.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index bbbde50fc649..f0164817d9b7 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -1316,6 +1316,7 @@ static int ovs_flow_cmd_set(struct sk_buff *skb, struct genl_info *info)
 
 		if (IS_ERR(reply)) {
 			error = PTR_ERR(reply);
+			reply = NULL;
 			goto err_unlock_ovs;
 		}
 	}
-- 
2.54.0

