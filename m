Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77A3437463
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 12:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786537214; cv=none; b=Ks2mlsaiXN6fWRxoB+hFST3bhPAAbqWwqB4taBOjD2g+V1yq4WD9m5HI97dHqhMcBfbKiFpnWUyxC6DE3oMS+1KP+d/YgdaYRvHvbCm1moUxSPsKCou7VfB5NQMEwYldQkmKwDDAOyV9j/zntE2+2gbDw7eQz28Xjo0/wtHr3tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786537214; c=relaxed/simple;
	bh=E2P35qMQA82O9D+HPUlzViJR8QajbNalF2+lY+pJm4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nIiObbo304xZsEZAKyWpZHV9RK2hyhRQpKpiI6KBHUMTT4E3dV3gbJ/BIO21ImzNGTlh+HI5RuzeSaOJO3H9nVHQzXBqYoWOnzFUGkgdv4gsWcCs7jmwIk07F3UKAmjBED/A+pmOxWWkkV8h5+blfG8a63NhxButXptH/xWPb0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-47f9c6bc99eso208735f8f.0
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 05:20:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786537211; x=1787142011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6b3OmusMYCc1ANkFu1Kh7AqH2Z3ZZ1CgYLFJClQdIJ0=;
        b=ULPmGqNFjxZkVPPmG+Sbay/8cCPAh+xsRtMInAjYo08nTaPDQgXh0MedtZlbrCIUIl
         kMf8R4kme5elNAHt9zLUrY4gjeVQuQ7wHzgsOPbpL1OjBg18cC18WpvAZ9G7fXTP3p7m
         8TPZjGSIvAcHVIGb6VFWjtcnrmvWw8n8QtxGnxOObHHaPBgx4jUPIGAnHsmQc81OkMEn
         ILIV6pUlsWw6nZ4lXG8zJgT0NbSY4R7Yfmy+5Mb26mZDBwm5YaQNDPAhkcjoheVcz6eI
         XThCrGJOqQ2w98b3W05N4NI/eUWtgjocu3ptHi+SNF8jQxLHw79tN/C4GQoUYmW5wPSY
         5ifg==
X-Gm-Message-State: AOJu0YwJzFl2hto9w1vJlhWi0WAkf+IimW6AnMXZtGT5oK0GPpdSTifC
	z9umBziclclVWjJsDG6rS+JP2Oaj/Mo6zbGV8jw753K1C2tOQ4FFTHNsj+SfoBJfMuE=
X-Gm-Gg: AR+sD11WkTcS0p1cPcttu7NyVCBednOaSs/QML9AwLsBGzu0qx/MFV0Kl8uWI/BxOfE
	Zd7dhteR8fcDWNO9AllQpb6tmJV75O9uCZnH17XTBq6rU8JwVMlh+wTvZv2A5Va86DDMvmPR8vd
	oOkbeZ7Bc6J2ahTNwTMSiieacdMZMhY22ft0PQAJ499TlD0uIhQnJfo1frmIKxRRCi94IczD10x
	x0FTwOMiwhK6JT99m9ODPyup+wwFH6mPD7sbSD/0iiDBtdOMkcS7kBJsWeepK2hnP2uKiQFMeAE
	I7Q3e92nlROBy/rfNahHV+fDbrzxem3NrH+QCMxy7DEyEnLf78dZiqbWl6B862Da9XsZzq+0N0F
	K8hykk0FoBbS3J1ZhQn3nohk6zhdQTVM9LKPd+RkuUrWBWOkoO0GlIcINtrej3cc297A7nziIKq
	kG3UwhltevRLN1xZLD+hlu6zCBcQeGQvy0QUFuZZ0eNQp+U8K2iKqj2xZUEVZCIMnQJEZw/nsoJ
	kZm46EAngKahbBoiiJ4/Q==
X-Received: by 2002:a05:6000:2513:b0:47f:8d71:210a with SMTP id ffacd0b85a97d-48152c617bcmr6737286f8f.15.1786537210782;
        Wed, 12 Aug 2026 05:20:10 -0700 (PDT)
Received: from im-t490s.redhat.com (89-24-57-65.nat.epc.tmcz.cz. [89.24.57.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48150c08920sm6635982f8f.15.2026.08.12.05.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 05:20:10 -0700 (PDT)
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
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH net-next] net: openvswitch: unexport ovs_vport_alloc/free
Date: Wed, 12 Aug 2026 14:20:06 +0200
Message-ID: <20260812122007.457136-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since removal of the legacy tunnel port types, there are no more
users for these functions outside the main openvswitch module.
Functions to register vport_ops are also not exported.  Allocating
vports without operations doesn't make a lot of sense.

Highlighted by Sashiko as a follow up to the removal of the module
infrastructure.

Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/openvswitch/vport.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/openvswitch/vport.c b/net/openvswitch/vport.c
index 29ebeb164bdc..083f7a8d9d4e 100644
--- a/net/openvswitch/vport.c
+++ b/net/openvswitch/vport.c
@@ -157,7 +157,6 @@ struct vport *ovs_vport_alloc(int priv_size, const struct vport_ops *ops,
 	kfree(vport);
 	return ERR_PTR(err);
 }
-EXPORT_SYMBOL_GPL(ovs_vport_alloc);
 
 /**
  *	ovs_vport_free - uninitialize and free vport
@@ -178,7 +177,6 @@ void ovs_vport_free(struct vport *vport)
 	free_percpu(vport->upcall_stats);
 	kfree(vport);
 }
-EXPORT_SYMBOL_GPL(ovs_vport_free);
 
 static struct vport_ops *ovs_vport_lookup(const struct vport_parms *parms)
 {
-- 
2.55.0

