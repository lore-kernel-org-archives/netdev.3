Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095D724B28
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 00:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789174486; cv=none; b=Wxtve4eG1/mj1nkxgL4EvEZCWY8KFyNt7iOJvxi3kyR5qFaT98whDf/bYyznekNC+07TPwTKRbE25k4myepbEHZNcFeQV9M0o3w2aPvX7BktedKoNjQ4UIDNc49Fd+fZk5V+eX6mv2rhrYUEL/XuCWLVnvgwuXxcGEJLBiUvljQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789174486; c=relaxed/simple;
	bh=uav+OqTa0onwGUtXOgM17I3sTXQlopCYZ4zhluAEerU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EGZ5TNRXqHBio4AddH910PN3yN/ARXIkUCDHgJmQ0suYZ6kHet65NRjgLi+YVtGZ3MquTR9Rrg6w1UEBtrLoSA+fbPPQYoFXd45A/VJsMfCtq19IGouXPQ+pyHiHCVuLI74fJDmcG5sbtv+3OjloiiIJTCBgpE2n7sM6i93wkrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=flyg3/Qg; arc=none smtp.client-ip=209.85.222.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="flyg3/Qg"
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-939f248907fso105428285a.3
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 17:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789174483; x=1789779283; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eiMC+qiKBTM1/YxutcQCaokj7L3cfipphlyZg0WCJx8=;
        b=flyg3/QgL4KceOpSFG60XEGTpL2QFRJHhW2BjnigET/E8WflXSXsBul/lfrryU3C8C
         JUzI2VMV+nng8iEmJbaX4M3zCCmeRbQj2czroykj1CimGF6CZLKiYb4O4fec+HLCaAp0
         7hRQBhhEkW1Bud3PyExPy8/74HNLGe5BUFRw7X+iioxFC9gxS3h+DtTVzjflgGaAO0hr
         Cb+mzAYzfZ2lCjw10cHRDsM5t/YwWj5bgFHdNAmpNsMDMIgzKFVjYezu68w08a0/5rfJ
         4TW5sGTWzERh7HdWqckz7DvJG78RlvQKBzL2y3Mr76kGngbQ3Bd1kM4g2uXosIDZOmWk
         D8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789174483; x=1789779283;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eiMC+qiKBTM1/YxutcQCaokj7L3cfipphlyZg0WCJx8=;
        b=jmo85YdMIevYzy5pkd37QlbiujCBEAteUvXQDZO9LJdmy8psdaWQ79i8msg11cRUl1
         ly5OMeba6zCkgzPTBFlcM/AABX6j8sknzS0jcltW6wyCWcR4gaXqk8TsMMJaHU56vfxb
         telzZ1Xsl4hSCzeK2+48vmwaJRPRMhTFhjoHVNUnSXXl5AWa8tFMErkn69D4lSrbyO/W
         qB745MQI7To7Kfe5XzI4wOZz3Wy/jw2v/WrfacI0xWAw/v1jTa7tsgXa4TgHgt1ciYwf
         3JiYzqJ6ZvZt3bNSMHCo+cSBpGDgTxeSHxFOxpO/ZjXhvvp8GB+AxE9k9OZ2bJ5VPrnK
         Il0A==
X-Forwarded-Encrypted: i=1; AKwUvBzHnyEoYuxAP1ASymkE/lMXuGx2mLZ45awNAfDjofSyh88BKM3MYOC5PF3IfWkfWrhu8wguptU=@vger.kernel.org
X-Gm-Message-State: AFuF++kfFJu7HI5lDWn+C8mrDhPfHtICspmohPVkxQG1kBLEpPtKlTmn
	qL9PyzP7ZZoSCGga+Qkrm6PzHNYM8V6ztLL8S5IeCAV1jxkB5g/kCe4M4wVDSFwSPQLY7DUdnKq
	nnWPxfzgwMTs/bQ==
X-Received: from qknry38.prod.google.com ([2002:a05:620a:9166:b0:93a:2c1:de22])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:d8e:b0:939:93a1:1383 with SMTP id af79cd13be357-939ea2037d6mr992415585a.32.1789174483246;
 Fri, 11 Sep 2026 17:54:43 -0700 (PDT)
Date: Sat, 12 Sep 2026 00:54:42 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260912005442.1795813-1-edumazet@google.com>
Subject: [PATCH net-next] sit: do not report an error from ipip6_fill_info()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

ipip6_fill_info() returns -ENODEV if tunnel->sit_parms is NULL.

This can not happen yet: sit_parms is only cleared from
ipip6_dev_free(), the priv_destructor, which runs long after
RTM_DELLINK has been built.

Returning an error from a fill_info() handler is still a trap,
because rtnl_dump_ifinfo() stops at the first failure and propagates
it, letting one device hide all the remaining ones.

Return 0 instead, there is nothing to report for a device that is
going away.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/sit.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 14ba3cfb304a83ee37e3be5b09a57c371f1977c3..a7ec800216ade169985d389ad1dc672f0358f4ee 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1853,9 +1853,10 @@ static int ipip6_fill_info(struct sk_buff *skb, const struct net_device *dev)
 
 	rcu_read_lock();
 	parm = rcu_dereference(tunnel->sit_parms);
+	/* If the device is being dismantled, there is nothing to report. */
 	if (!parm) {
 		rcu_read_unlock();
-		return -ENODEV;
+		return 0;
 	}
 
 	if (nla_put_u32(skb, IFLA_IPTUN_LINK, parm->link) ||
-- 
2.55.0.1007.g17ff1f9808-goog

