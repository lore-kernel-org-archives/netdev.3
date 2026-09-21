Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B5E4A2E32
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 14:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790002653; cv=none; b=FX1om8yt92VQH40UwaRrjJdopquNWXr9878guVVbMpDvXWfElaDjppSI52cDkpVQLoCV7lRQgXjGfUnje1WzbqVzNNvRnzYMEnDJKcAZ77UmP9cER8I8K6/avw2t4D2zqdQxaudCoicQXXrGV+G8V+/nX5lmpq4k2bqHGthpomQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790002653; c=relaxed/simple;
	bh=agbzHpR/PKZ0LLlY2lgVEH4d4x1op12XsKxqX/dfCv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CUk55QLiCwmL9f5aM4uPCj6P4KaXdGTaz8EAnE9KN9PBsWWvzQosFKvOCcDb6IcCWZCyTOf8nKMBLVIOv14qzBECX+B8lZbJFF4G+JsbcR/jgBZim3AUeRtMAIE94YLzmtF8wfH2vWhRlbkcoRVevh+f0maYkVN+u5dby+sFO88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49e6bd65693so20717125e9.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 07:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790002645; x=1790607445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0GaJZ+uFEU0tQWZqiav7JnKznavtITsSwryC+6XFRoE=;
        b=Xl/FVs8Wrtcf8dMFyeex0xTb3n6kWn3c7Wq/5gMGpuD+/TFEShhIQYvWWHIWWqNIrS
         6wuvEu6puCvJmD5URD+pc/57Ryja6UC++tSzMejyqasygBFFAsVJ/2giCBBmtXpLT4kT
         lCFGiF8+fM/W/HxgEKLDi9oPyed5XJfgu+4OjXmrI+rpIxMmbBcalDuH8bCWQYXP6gok
         6bxycBvfad+oKW7fFeSpL/IpLeqqAtWhtem377r/VNnfD+MIQ+hdzox7YZLYZ1PsJbAp
         0NJ5Oy6MRKLr0W+mX6j+g2osy5jvCI16uJHiYTBIN6vWqRFxL6xpmTYfR/yp4jGCI4tD
         SMHg==
X-Gm-Message-State: AFuF++kHszxQehcWZujlSpIjpgqYh8jlB7kcDwJ4gg2tVF5hLwpmfJnb
	feu/qgaQo9K2Bg2sWIKMB/LEV+mSBYvXkLJriSw3ZrBgdfhcvky6sirTewESNg+s
X-Gm-Gg: AYBFou0IaQaA3XEIBjuR9Pu3rNKvsDEadPKU4RjIEZJgppdEhKIZhVRF838ZwwQN6vB
	7RSH+sYapprkm/QR8pAC6kp+i3rN1ulBEVccj42bSLNFWrK0s4oLfj5rX+jBR1+wrDdn3fcQ4rw
	CpEIEQYzkTeafAAzXje0Ff8fkhusZv+SJ6J43fqS/XiNIlEjk1T/fLGp19OfITa9lellqeCyGtM
	kt0pAWmZ+keUwM/9+J1gc2G4pPOF6okJWZABJNVW9luyeMN8gfGSuGQ0AxYOupzxs8Q6xGqPJxh
	Zrx5CP6BHea4rALcTEXkJNrnei5s0v+0ZaMs2J4ut9Uzw610QrFtGHUSBBKMqYbUU/5bLfifnlB
	IqcZEWHbqhWddPPndbxRUgiC+9nlCsRa4nE5j8XbdigoGsBB11SfS7CqQxqSG/6kUEYHB0ex1oy
	MDsE4EKYM13fH2Lj0pxXpOAnxG5G6At0cAEsNdJkvl634dWpOp1ARoCDiRv2ASqh1uDGDsHzSaj
	r6AxPia5w2TADxwZdl7BKoYbqQRwKDn5fENyzUFyrpqyQKkrXXf4cNBvWCaKnw=
X-Received: by 2002:a05:600c:530e:b0:49c:cfbe:5a76 with SMTP id 5b1f17b1804b1-49fc568157amr140231615e9.2.1790002645153;
        Mon, 21 Sep 2026 07:57:25 -0700 (PDT)
Received: from im-t490s.redhat.corp (78-80-107-225.customers.tmcz.cz. [78.80.107.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd0eabfcsm243153905e9.3.2026.09.21.07.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 07:57:24 -0700 (PDT)
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
	stable@vger.kernel.org
Subject: [PATCH net 5/6] net/sched: act_ct: remove 'add_helper' dead code
Date: Mon, 21 Sep 2026 16:55:47 +0200
Message-ID: <20260921145655.3167436-6-i.maximets@ovn.org>
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

This variable can only become 'true' when the connection is not
confirmed, but it is only checked when it is confirmed.  So, it can be
treated as being always false and just removed.

Fixes: a21b06e73191 ("net: sched: add helper support in act_ct")
Cc: stable@vger.kernel.org
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/sched/act_ct.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index e72143d36b119..f62051ec9d57d 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -986,7 +986,6 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 	struct nf_hook_state state;
 	int nh_ofs, err, retval;
 	struct tcf_ct_params *p;
-	bool add_helper = false;
 	bool skb_is_ours = false;
 	bool skip_add = false;
 	bool defrag = false;
@@ -1096,14 +1095,14 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 		err = __nf_ct_try_assign_helper(ct, p->tmpl, GFP_ATOMIC);
 		if (err)
 			goto drop;
-		add_helper = true;
+
 		if (nat && !nfct_seqadj(ct)) {
 			if (!nfct_seqadj_ext_add(ct))
 				goto drop;
 		}
 	}
 
-	if (nf_ct_is_confirmed(ct) ? ((!cached && !skip_add) || add_helper) : commit) {
+	if (nf_ct_is_confirmed(ct) ? (!cached && !skip_add) : commit) {
 		err = nf_ct_helper(skb, ct, ctinfo, family);
 		if (err != NF_ACCEPT)
 			goto nf_error;
-- 
2.55.0

