Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DA63BD24A
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 14:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790002639; cv=none; b=VGV4prPwXaCo151wMCZT0oAgxj2bMuCnJKVSDYNNAPsjMUaCLIkQLQHgATdcPmYrGBo/z5xrsPnkAZsxuuzSlJ3K/tKiElTUNFysKXrcCqAF3MNJ6ONjw8tQLdahx2TXu2joRwq+kRS8eyT9qnM2ImfgD50lbtmknXdYC3C0OCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790002639; c=relaxed/simple;
	bh=bOu2j+h1JsGrW/73PwD/ne4SKy+cAAoi4+vaYnS3JPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RnuxShonrApo7AOdlMxiTOox8hXck9AGYHzpn+3BFWUkVUOO1WK+OdfkW2UIisjLxMkf+prBVLuCdbmC3rcm9vHo+c2GkhvZkJv7/X+Our7SCaFOcpltKoS1C8HOI28ecSpMT8Yu71PacAxvX07IzCGIfUxGhqnbnjQ9K4wg6AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f7.google.com with SMTP id 5b1f17b1804b1-49e8361492fso12426515e9.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 07:57:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790002631; x=1790607431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1ezyNqdfklEHB2imnyaqpGNvPz3WXjxpC3pksDJMQYU=;
        b=dToXGRVgn27o5pZKGyb9Dv3IbDZL89YaN6tRS2YajGAD72hPFC2OzSIQqYSjoCxpKi
         ebBLtsIoz4R3SNzSuVtnEKskIc0YGIWwxVkC8JnI6F3ZT+mVKpM6TQ2etY3wJPcI4wGu
         C9A0wBqYO7bIyYelQS8GbOOHc2068h/4ZHr4Cg1kakuzvjJi0yJ2wvBo2P+cn/UnZJmF
         NbDBHCwLHRMFLC0IK+TuXtyugncO23WiLSA/9V5xRrexdRkq8p5kcFhwkGou2nIF4lCb
         gvTmzJTnve0XdYUVGO4pNYEBi6IHpCj2IH00QX1J1dsXhEviA76QVcwNeMkkVRIH05ll
         agKw==
X-Gm-Message-State: AFuF++njfxbag/ip2oOGqjBPTjEI9d5RwL40kGMbS2tX1oSyvbY/+sYM
	t2/3Ug1CgEkAtpA0BrXZXWCh6ENKM7b0vWnQ0KbPBWchHC7tBXtqQIplHziN1lYx
X-Gm-Gg: AYBFou1wAo3Skage3AsjSCMR3JQIpAR+ceV5hgXjDrVuRI/AMuC61rPOXlP9kYdB4bP
	2XDCsn9E1D7GpkOlRa3keDfL4Nj4ZMT97XrOhyWfXgn9QPrpd7/AYDF+WJg28sfBnb5/4Mr37Ad
	Zgn2feJJYwlzSB8+3WqAjc+CiuvVtTj41jiAjP/7I8rWTlpg5dhbZSICwmBwGuuukUwfnIWo7ih
	gjxvw8UDZyJGaFbfRuVBONVY+lQKY45b9I6mBCKJRXPU2NhbHcpOJmL8gipBLFGrIZ5uT33hxKS
	844Hi3/xedy63T400/TQTXc3xE+5pzSzbv0hYkRt1SbO6ZcitucWU5ZQjs0m9DPJIpIcewMCUdS
	Yxfpp7wXhingcpLsZKTnWVWDtvNBrQttuYS6mCLCsM9onFAQxNg/Egv1H3bweu1QAa2m7774AFu
	RvYKDhWwisE+mdqKAcWd4l8o2Fuc7IpbKH6Wphl0d6sRi4I2bTwJ2tLUWUY4/yTz9sAWYTYYzHr
	Y+SI03RCGMp+FsvLsyccTsf5o3MmPRwzcTapCcgppS+YJJ4z+QR
X-Received: by 2002:a05:600c:3493:b0:49f:bd3c:bc21 with SMTP id 5b1f17b1804b1-49fc573b55emr150845005e9.28.1790002630316;
        Mon, 21 Sep 2026 07:57:10 -0700 (PDT)
Received: from im-t490s.redhat.corp (78-80-107-225.customers.tmcz.cz. [78.80.107.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd0eabfcsm243153905e9.3.2026.09.21.07.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 07:57:09 -0700 (PDT)
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
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH net 0/6] ovs, net/sched: fixes for UAF after conntrack extension realloc
Date: Mon, 21 Sep 2026 16:55:42 +0200
Message-ID: <20260921145655.3167436-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One clean up change plus two fixes for the UAF on helper extension
realloc x 2.  First half for OVS and the second half for the similar
code in act_ct.  This should cover all the known cases of this problem
in these two modules.


Ilya Maximets (6):
  net: openvswitch: conntrack: avoid modifying shared unconfirmed ct
    entry
  net: openvswitch: conntrack: remove 'add_helper' dead code
  net: openvswitch: conntrack: fix helper UAF due to extensions realloc
  net/sched: act_ct: avoid modifying shared unconfirmed ct entry
  net/sched: act_ct: remove 'add_helper' dead code
  net/sched: act_ct: fix helper UAF due to extensions realloc

 include/net/netfilter/nf_conntrack.h |  5 ++++
 net/openvswitch/conntrack.c          | 37 +++++++++++++++++++-------
 net/sched/act_ct.c                   | 39 +++++++++++++++++++++-------
 3 files changed, 61 insertions(+), 20 deletions(-)

-- 
2.55.0

