Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0EB4AAC6D
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 14:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790002643; cv=none; b=eQ0N6oaXYnncZvuli1kh3NcFp9RHLIbhpEFJJJEGe92FTSVNzNYZRh7GZEft1lxerFcAJRCPYZnS5WAoLXzTv++uj+4ggkEZSj6L+xEJGgDmtnm6D97A6EVKstbHjLNX6B3ewblQUTHzY05QinQiKnPHWtZDuj2BNsTb4IT2DJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790002643; c=relaxed/simple;
	bh=GewYnmEL4DmNXoNcMZj/SIhw9+Nkv+8Qj+/vw7RBrBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FiFYfQt5l1uLvBZWvd742hR7ZIGhH4I68skg5MgIoPRDAdtpQljoI3Tg0Q0nWtIQIWX3BLeOyFPkqa9MqVIhWsILzZLUoY1rdukqwttQS8h64Ovv9xOGrpCNrUE4+gJFqNQdrJ/Qjgp3/484MlVO7lFhFCfZ1W3VCoKz5Ptbs50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f7.google.com with SMTP id 5b1f17b1804b1-49e8361492fso12426765e9.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 07:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790002634; x=1790607434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pQTMqBWHnIAoQBjOra2YMizNpxK4ySQgVrZe7YnTaiY=;
        b=M18sorhrA52IhfrOd2KrdnByuaH6+8nzCEFI4sl08dbsjoVaclOqSjURE14NKAPBNo
         NZHhifqI9UhoWdwofy4vijEdJWiM+S8fwyTXbbxKONubs+zVDp2AUdUoaoEujBgLHhk2
         iSLfOm6XvKhMOL9aJ2HqYnp5G0g5Tnr7efFJTAfCYUZgqrz38uyX63CF4L3vKDkdGb27
         qfFxhQ8q0x0t7Gm2eYUBNc1xD4y+kDSxeMP5+btFgYKOQtMEm8vedgyvbbHf365VmJoY
         /DN2tA2REIOjDSEm9fmv4c5/MnTikxny2qBe4W65q7ppyFs+BSUj3ODV8BveW8pJb7jI
         yCJw==
X-Gm-Message-State: AFuF++nYAopN/OJZE7SwTHyL4i0Mn4+kxqk+0YTAUG+p82Iwb7583TtD
	0PEx9o8IOwNfJlcHxXfv5/I3XF1iBQ30epjcOao0+o03CVIDJP0NNjxTloRN6X9H
X-Gm-Gg: AYBFou3z+o5L2zbeu7BSxRa3+ls+7XdhwpCfjCMiODUFlSLhXsl16zaf1IuKMPrrAXm
	M1IlDsLnrdljpe9JuodZ7i6WcNzszfbcjHe+Oc5+XcOLE46BgrjsqEZbe3eod9ZOuDoez9jmWRr
	/JvLhyDGR06sLlBFp8ECYu+M/GhKGxrgRpXWTX5kavYzMOusE7rt9h+NVscf+DPYrgnNLko2jyW
	QqKKDKfFpGRZc1aqT5nDlbC/5Y497N3B+53QecS1mnnW2xu8tfHKiLA1P+A7NJ7FGTWcML22CR6
	OE4+++U3jBRnTUnXCvDxtJdXWccf4lB9zgIZ9JcacWGEMvquDemwtK/WCd6VCVV5fDRvvff06vi
	JYmnanaHL+WRWYt/AikcQrSv8bnNdUROdFEJ2UQONF8dfKWeiY7lQ8No+WEOpJ3gYfbb7Y7zphI
	S8FMVhhXTDnp2i5nEEhbHsi7xvnupRxf7yfyIMnbrU79mNKwNQEyprXWnYYZ9d8T+jeZPdSzWdm
	CzQqvZT8eDkIqUI0FU2D/ccdeUlZdQpIFb97iAeaBTEq5M3FE4k
X-Received: by 2002:a05:600c:4e86:b0:49c:d52e:d0ea with SMTP id 5b1f17b1804b1-49fc566e6efmr144949645e9.4.1790002634076;
        Mon, 21 Sep 2026 07:57:14 -0700 (PDT)
Received: from im-t490s.redhat.corp (78-80-107-225.customers.tmcz.cz. [78.80.107.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd0eabfcsm243153905e9.3.2026.09.21.07.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 07:57:13 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Xin Long <lucien.xin@gmail.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	linux-kernel@vger.kernel.org,
	dev@openvswitch.org,
	Ilya Maximets <i.maximets@ovn.org>,
	stable@vger.kernel.org,
	Axel Mierczuk <axel.mierczuk@1password.com>
Subject: [PATCH net 1/6] net: openvswitch: conntrack: avoid modifying shared unconfirmed ct entry
Date: Mon, 21 Sep 2026 16:55:43 +0200
Message-ID: <20260921145655.3167436-2-i.maximets@ovn.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921145655.3167436-1-i.maximets@ovn.org>
References: <20260921145655.3167436-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a case where skb with an unconfirmed ct entry gets cloned, we may
end up committing both but with different sets of extensions.

The series of events:

 1. The first clone wants to commit and runs the helpers wiring up
    the extension pointer into the expectation list.
 2. Then it looses the confirmation keeping the entry unconfirmed.
 3. Second clone now wants to commit labels and adds the new extension
    for that breaking the pointer in the expectation list causing
    UAF on the destruction path later.

While this is possible to trigger, there should be no practical
network pipeline where committing both clones without modifications
into the same zone is needed.  So, let's just reset the entry in case
for some reason we got an skb with a shared one during commit.  This
doesn't affect any known use cases, but avoids any potential problems
with sharing and modification of the unconfirmed ct entry.

The fixes tag points to the introduction of helpers, since that's the
main UAF trigger for the sharing.

Fixes: cae3a2627520 ("openvswitch: Allow attaching helpers to ct action")
Cc: stable@vger.kernel.org
Reported-by: Axel Mierczuk <axel.mierczuk@1password.com>
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 include/net/netfilter/nf_conntrack.h |  5 +++++
 net/openvswitch/conntrack.c          | 12 ++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/net/netfilter/nf_conntrack.h b/include/net/netfilter/nf_conntrack.h
index bc42dd0e10e65..c39425e54d87d 100644
--- a/include/net/netfilter/nf_conntrack.h
+++ b/include/net/netfilter/nf_conntrack.h
@@ -185,6 +185,11 @@ static inline void nf_ct_put(struct nf_conn *ct)
 		nf_ct_destroy(&ct->ct_general);
 }
 
+static inline bool nf_ct_shared(const struct nf_conn *ct)
+{
+	return refcount_read(&ct->ct_general.use) > 1;
+}
+
 /* load module; enable/disable conntrack in this namespace */
 int nf_ct_netns_get(struct net *net, u8 nfproto);
 void nf_ct_netns_put(struct net *net, u8 nfproto);
diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index 0f433688e17b9..a733029c28dd0 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -734,6 +734,18 @@ static int __ovs_ct_lookup(struct net *net, struct sw_flow_key *key,
 	enum ip_conntrack_info ctinfo;
 	struct nf_conn *ct;
 
+	/* If the ct entry is not confirmed and shared with some other skb,
+	 * e.g., a cloned one, we can't just modify it with the commit as we
+	 * must not modify the extension set.  Reset.
+	 */
+	if (cached && info->commit) {
+		ct = nf_ct_get(skb, &ctinfo);
+		if (ct && !nf_ct_is_confirmed(ct) && nf_ct_shared(ct)) {
+			nf_reset_ct(skb);
+			cached = false;
+		}
+	}
+
 	if (!cached) {
 		struct nf_hook_state state = {
 			.hook = NF_INET_PRE_ROUTING,
-- 
2.55.0

