Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4174A99DC
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 13:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442441; cv=none; b=uW4lI+iuAwDh2gEjbwu7frBifDSbjpGuTV2Gs2laW7lsP8CDt6lavz5fht80wUHURREJfatEMNZiNsJVsP4nju94kFo7tnfg+sj/JPr8kQCGV7iaaFylre6TXO4BadeeQUrlUh9ldrHiWAxNOu+3m3kCZcvbVm9e49hhux/wl1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442441; c=relaxed/simple;
	bh=tkBDL4pkwJNZzO9dijwy6kiKURo5w2hkiNZAndxydQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XOLgs6nlKRjzzgKbOVut0a6s+ChJZb3G5U1NMMseV54KTl6d2ofpwBA3js9TpCJQkfA4DS2CH150idiiukVO/8B1Rh4XifN73WZ2e31MPbc0NK7B9lMd9AqNYVRuQBjgPzDe7pXDWsOfLt/l4n5/oQdOmIreKlWOJVo3w0eklnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=RZKwQGvO; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="RZKwQGvO"
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-399213ef56cso1001965a91.1
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 06:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1788442432; x=1789047232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NvKqkVuc3hDZQpQxetS/ZUD+52DMOOEV2JwJLL/kRXg=;
        b=RZKwQGvOq4IZf+jxhxjsTfDYratifsMMXUooDtYoYOslfDmsbQYZD1oOJBCxb+sAJx
         wLJTSiz6QUu7D8taClCtrba9bbJgbEYl6U78fedH3CK/tRg9wrV7XgP7YrVSDr23WZSL
         aiz7xhzgPcY4UG7sQomEuPQZN+htN5X9Mb/151VSAxYJj6cK8Vjs6me3KWG5Es6/3qUx
         fCgKVdjovj08gXnHqzWtXrUQZQZqyqFtripFqNo7fvKzV8uRo/8ye2AJIEnXuxX0vQau
         wnqJatTSpKonk/CzfwNOXWN1VEMRkpNFbNSC3zR7Ro1zPqdxDUr5SkfKFxkwI3Ot1Wen
         HxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788442432; x=1789047232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NvKqkVuc3hDZQpQxetS/ZUD+52DMOOEV2JwJLL/kRXg=;
        b=LLDVdXXDWg7JUJJuInzWCbYpjI0htBRf4t6n2dKI9q9mJR0ChWDlZUqI+IS11bvUM5
         LwE9dEHi0Mym/dtFmrRup4gA2QcfJCzumauZPcDYjnbs8spMVRlOSe20a2wCBof3zvnF
         ghlkZAYHPyr+N36qz0mbpVpg0H2caVBnatE8MQwFBWHajqwPgyOkJO9jpLkrQwYiXMjX
         U8cP3zy7zC4k9xI5Qb+xOZfjLenbSnP8t4r3qI2q2yg8BTFB9QlSBpBfsgz6mY8gc4t5
         DxZjS/ApAJzuox1yViixEMj7bxU+tda9gcJ9csf0QC7xE8CTW7htKx4OHLqOJ6WiFOSr
         s3ug==
X-Gm-Message-State: AFuF++lCFYxOr//N+y5P851o3Psau+dWystnIShaqWisnUmmFVG6SrIh
	fkS1ZYJB64/WxPRHuppzW4Ug9XmZ68otXZ0IAmjMTGThdA8gCmmErMzf43g9g/2xn85X7OkXWe4
	SZUyn9vKsgKkZAOfxLCw1ZpwAi1rQ86mrwUeDsMJAQcfrwXGN0F1pWsM2Ec90tOPAgnmrdtbCKg
	IUOWme
X-Gm-Gg: AYBFou2khp4nqbenyHUZcB1d3gIklh7dq6h7Dhz9ydok7AjNZwhEBtS/xAVGdwX9PyG
	HDM9NqbeKIWUiSAAw+341UnKrG1QeSCUKhOhPNdZVJdT7Xs5iZFhvJWzrbRupCb1ETpS6S8G19J
	enj3Q977wW8xlW/b5uYZGoHsBEB//VUpnEQonADVjLMKJei3ODcTHa2YngYpQAUvOefoUYcohr4
	iwLGGOiC2XwXo8kOdX7DtBGTLhjqPZ8gmmYw+JJ+qcwJnzBI257GGbA4z+U5FoJPgnhdbmnxmLl
	Cbb1bOnOhYApbYZKNakAfZ+EFVCHvqxUBAEeuO5dRrkV392VitTW62Wh9qqoEPyeiOvoCNEzkF1
	oo2Qu5OhwyvHJIyXolviWQl92O6Ei1g5MTQsdJm44ddKxDTwDVWTtyAQGrTIYeBy7ELmjO3K+59
	YTFgbGvgpGp2pHHooClP6hxZshv5AJNWdfhcUN3MNDByyPC3Q1pyJysoVVYDi9eDjmxPnrwl1az
	hA3VAs6032D
X-Received: by 2002:a17:90a:fc45:b0:38f:efed:5448 with SMTP id 98e67ed59e1d1-39aedf2014amr19306784a91.8.1788442431289;
        Thu, 03 Sep 2026 06:33:51 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.128])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3325534e83csm7223347eec.10.2026.09.03.06.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 06:33:50 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	keyong.sun@smartx.com,
	Wang Zhan <wang.zhan@smartx.com>
Subject: [PATCH net-next v2 0/2] net: sysfs: use ops lock for speed and duplex
Date: Thu,  3 Sep 2026 21:33:12 +0800
Message-ID: <20260903133314.3703381-1-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reading speed and duplex from sysfs currently holds RTNL across the
get_link_ksettings callback. This unnecessarily serializes monitoring
reads with unrelated rtnetlink operations.

On CPU-throttled hosts, a periodic reader such as node-exporter can hold
RTNL for hundreds of milliseconds while an mlx5 callback runs, delaying
unrelated rtnetlink operations.

Factor the shared link settings read first, then change only the helper's
locking. Legacy devices and callbacks which request
ETHTOOL_OP_NEEDS_RTNL_LINKSETTINGS retain the existing RTNL path.

Changes in v2:
- Split the common-code refactoring from the locking change.
- Keep speed_show() and duplex_show() focused on formatting the result.

v1: https://lore.kernel.org/netdev/20260831080623.1064001-1-wang.zhan@smartx.com/

Checks:
- checkpatch.pl --strict
- git diff --check
- x86_64 defconfig W=1 net/core/net-sysfs.o

Wang Zhan (2):
  net: sysfs: factor out link settings read
  net: sysfs: use ops lock for speed and duplex

 net/core/net-sysfs.c | 112 ++++++++++++++++++++++++-------------------
 1 file changed, 63 insertions(+), 49 deletions(-)


base-commit: b35d3d2fae3058265ba937544a3895cedce18d08
-- 
2.47.3
