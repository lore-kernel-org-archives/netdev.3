Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793069211;
	b=vANNF3+fU1Q23Ay9OGRQp4TsCtcLL3oXBNhnE3M9LtiCoy6lPc43lE7tNYY2JdIxNZr0
	 UzedCM0/rnOcxxD1yiTVAR7JaLxqa8dcBigS/Vy8DMYxa/qXXibeVYcWR1uPcnx7UGSuj
	 7BRgu/Hn4CO2fsXPDzD+vH5osF2hun9ESSJsIVUs7Jh+SewU8bQ/oIb7BbP3CV9lcSp+0
	 utXsiWya2pVzzPgoQHKph4Ke5UN+WD6QkAkhvwNApxxn5ZNN8Wqbahp4JCKSN21ROPvXM
	 iV/2Sbe96koZe/hnI7uSVmqgJZaJB8EwskFMGyWT6eaSG2LqAjS/H+p9Hv/duKUw3KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793069211;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=coxZgKrnJnZEH72/LrsRIXDbgDxnkuCnDoogWLb7pp8=;
	b=ttf9PKsg2/aQIBf6DaeJ7OIEBL/OVcWaevAI3GXEdJq67zGKUlmBNRga02oNuG5r/tel
	 5CWZpKsyrE7FRTAuw1zNQ3VVFRx7669VOlcoKQJjZrNMJc7HY0JfXR4qXwCfg7cx3KZPI
	 av01j0IrnrEMoiIhW3bnXug2P39Wce5KqteBqbF4AhpE4CjVCPVNVZLW3iWTBo4Ulbk7z
	 iTGtpccP+lhlKGoBs4bW/A7dmXDEcsQd3o/u9cfRnMb5SBXQ1V3N26QRaXPoN2t4E5Xe5
	 cNHYjdCKYKnlXa2UOWL7oUPVBVuvKS9CVL+i1XVV6Sx1Th9XX1ee08Jdu/6cLMMSBKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arista.com;
	spf=pass smtp.mailfrom=arista.com;
	dkim=pass header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=PoGEn+ZS;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D7A606A320
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 02:46:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7D7A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=PoGEn+ZS
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-36661f953e4so6782821eec.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 19:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1793069210; x=1793674010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=coxZgKrnJnZEH72/LrsRIXDbgDxnkuCnDoogWLb7pp8=;
        b=PoGEn+ZSZSHDcDU74OOAemtouk8b4YJ9w2+w1DghVB1lN/xfW4sEfZhlHJXZJWBraK
         VA1IN5HWxRLkwkoy+HKDS5QhtB4txJqBv38G+pSv5t4WWR1TdrjGxDSG0RlJHI6vvxvi
         DJmUWCYMYTIkrgNCaZFXgNigmDIgxagI6n8ruIP5k5qoLyp6tEPqKUXnJPr64E7cY6aF
         QlEgLmadeZLMq2DceW3moY/ZWuJk/TVxUfEK5dbSvwoqLtUba/DSoEm+wFCVDM3CPJ90
         0V48qIdp/en3GSZVyKTmjzgb4PFDLIGrc5r8mPET2kkFxGOwj2qRQ6ZW96Tj3UK5mTa2
         bQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793069210; x=1793674010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=coxZgKrnJnZEH72/LrsRIXDbgDxnkuCnDoogWLb7pp8=;
        b=vG0Y+SghVTOiZJyrsu7jUu8NQ+k8AfPJcy17cH6NjnfgVsyfqOE8caNs2NLgi09QTR
         WxmIE7/FMdJ4QhWwPO1h5e6cxsvcZcjH0X1Krnj4tMGmnbrQmPVrPcCpikgFniuSjCAZ
         XP1KSu8rd8DM2azYM5JLtr7IP7pDsU+jQBLnrhZabnvwpNMGVdmH5BIHOQPWdAehZzpY
         N+L83MGUbx8wAOaRwu4NAzD9rBbUuVcsrjgvaFvzK3egYlCJ88RYj1AzVQl60WVYxDqB
         CzYnrJS6XHv7QVjRn4T/kynM3r2JaWOsC1AX/b9ZmiSlPZYEsL43FCN8eLofI/bifxs+
         D2Gg==
X-Gm-Message-State: AFq9FYIErC/ljiWfO/7gY2ySnOtcLSzmclbzOBrb+ykY12MneIIq7k5k
	50zMLM/Ylj2tnb5M9n6VgOjA8eji2KWPmAHNdq1JdjSjqYQIhKnsTUAWetEjN6VR4jMpyTc3Hez
	kkInGww==
X-Gm-Gg: AYBFou1yFxf+qSJZSMQcBNdHeYDvOC4vnGvs/WK+8owLb/HurKOvJfXaToHAqNZb0+C
	P0Kc6AnemUz6HK5L2d6lqSV+rDBR/MXGMggXIJTwb+HnYK5rt5tec9Q8hsTwsqdV8Q2sJQSxxZu
	9PU4hrZJjkqTjqnpK/E6zEL5k7k6FB4uX0M7CHLKvxavQMAPj7LKM1kFD6mZ3fLekrHz/DgM8dt
	ImCkFATNRGX5qDHsSeCyMhSgGn9XscAgNeIvpjCSYH0qA76UatJ8sa1auI8dbkVdzWjqmiXEXKU
	gbPKjheMLU6yjXOVG/H+SwKawy66eh3sj4XXeC9zJeLTxDy2Z8PTFmWJ63YnQ8/ABqd3DHp0Rkf
	8lCRfNu2HKAfSoqub9D3aKXhIF757GnjS10obmup753wkeDQXwc3lV8jfi8AnYaOIR1sn2mTXTo
	eg7rhEepOXqjxbA7Fh8xIMWXbL9swgqscddgFjMoDj8ybMmsSexMjtEv0KN9p7GbbvaF/g4OpyS
	0gyk8v0WyADCzKfiDcMudYZRKUNA94HNZQ2eDuFdi2K5lQuoeESZgxhxObCrH00g9JXcNEpqUqC
	nP9SbMYjVqKvmQ1PYMAgm0lpPCyb/hI=
X-Received: by 2002:a05:7301:1694:b0:368:da6c:4fb6 with SMTP id 5a478bee46e88-369e84ba936mr17506180eec.18.1793069209838;
        Mon, 26 Oct 2026 19:46:49 -0700 (PDT)
Received: from prasad-b546768-0.sjc.aristanetworks.com ([74.123.28.12])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8d8a690sm28967702eec.12.2026.10.26.19.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 19:46:49 -0700 (PDT)
From: Prasad Koya <prasad@arista.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	prasad@arista.com
Subject: [PATCH net] macvlan: fix allmulti reference counting in passthru mode
Date: Mon, 26 Oct 2026 19:46:35 -0700
Message-ID: <20261027024635.366900-1-prasad@arista.com>
X-Mailer: git-send-email 2.51.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enabling allmulticast on a down passthru macvlan, bringing it up,
then toggling allmulticast off and on can underflow the lower device's
allmulti reference count.

macvlan_change_rx_flags() only propagates IFF_ALLMULTI changes while
the macvlan is up. However, the passthru path in macvlan_open() skips
taking an allmulti reference when IFF_ALLMULTI is already set.
Clearing allmulticast after opening the device therefore decrements
a reference that was never taken. With no other allmulti users, the
unsigned counter wraps from zero to UINT_MAX. The next increment
fails with -EOVERFLOW and reports "allmulti touches roof".

Signed-off-by: Prasad Koya <prasad@arista.com>
---
Reproducer:

  #!/bin/bash
  set -euo pipefail

  ns=allmulti-test
  host=am-veth0
  peer=am-veth1
  mv=am-mv0

  cleanup()
  {
      ip netns del "$ns" 2>/dev/null || true
  }
  trap cleanup EXIT

  ip netns add "$ns"
  ip link add "$host" type veth peer name "$peer"
  ip link set "$peer" netns "$ns"

  ip link set "$host" up
  ip -n "$ns" link set lo up
  ip -n "$ns" link set "$peer" up

  ip -n "$ns" link add link "$peer" name "$mv" type macvlan mode passthru

  ip -n "$ns" link set dev "$mv" allmulticast on
  ip -n "$ns" link set dev "$mv" up
  ip -n "$ns" link set dev "$mv" allmulticast off
  ip -n "$ns" link set dev "$mv" allmulticast on

 drivers/net/macvlan.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index afad90b9222a..e20d587453d1 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -643,6 +643,14 @@ static int macvlan_open(struct net_device *dev)
 			if (err < 0)
 				goto out;
 		}
+		if (dev->flags & IFF_ALLMULTI) {
+			err = dev_set_allmulti(lowerdev, 1);
+			if (err < 0) {
+				if (!(vlan->flags & MACVLAN_FLAG_NOPROMISC))
+					dev_set_promiscuity(lowerdev, -1);
+				goto out;
+			}
+		}
 		goto hash_add;
 	}
 
@@ -713,6 +721,8 @@ static int macvlan_stop(struct net_device *dev)
 	dev_mc_unsync(lowerdev, dev);
 
 	if (macvlan_passthru(vlan->port)) {
+		if (dev->flags & IFF_ALLMULTI)
+			dev_set_allmulti(lowerdev, -1);
 		if (!(vlan->flags & MACVLAN_FLAG_NOPROMISC))
 			dev_set_promiscuity(lowerdev, -1);
 		goto hash_del;

base-commit: 7076f684d5132e6a6145e1da2fa74771ecd052e5
-- 
2.43.0

