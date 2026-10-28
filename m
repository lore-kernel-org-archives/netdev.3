Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793223359;
	b=1hQyqunYTMzTBOaUzupjq4ctVzTLdySyftfNXc0fSIrRk1JKQKlMfndalLiDEe6gtHpY
	 dqNWi9nHVflnFYsK744z1u8kRjDcMlTdnmt9LJg24ChcvGR2NQwvVORNA1gTRR8ZK/JG1
	 /G+hPmIgK0fGdwWPKqZB/8feFfF6kS0f9DtBv4HttYcl/wpyomrrSe46KrR+vdYpZVVrE
	 u7ymlw3k2rIvnQeF5wZkbQizJiMRpgYalnqir6eCTRoPFvyLQirrLfv1/YU1PwwndlJaO
	 GyhVzfm5OwPlykuOjiqjyQXSo0DriAH9zZk2dIZ/IUjGJ892mV2T3Fumot2RY+uUmow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793223359;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Subject:From:To:Cc:
	 Date:Message-ID:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=C4z0s5i6m6Cm9i1YXIjTnLWI0y9WJTId6/68tOJJcxc=;
	b=k8Rq3RBaMU1k7To2Z0rU/9CdZ45jcnSO0is2i4MgKLfChuQyoXClB2XZpaXA349TAOcW
	 eMwD7Du3NBlkUvkWxnARcBYffI/9YI2KHwd25AWDlJGsVm4pis67cb8tHd3jmFcU0wvlQ
	 XSNl0tkAFPiu2ucuRFoGsaWK5dFUjAmaHZ7iHLD9PBUkCcR0j89UJmYAdge0mqi4QhcMn
	 PVCW1Y1rxWZwAio0bNIfqZRv9Fwx2Z17/8vrKxh/yZywGJzqJMkNSjT5HbHsHJVY67t5c
	 P1UnZaIvsZw+OJtmYEsyL5dFgEE3F5lqy12Peuf1b9FPMeSKErETVKh7jxKBrgWvGWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pwtLorr4;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED292606A31A
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 21:35:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED292606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pwtLorr4
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3a4b3ac8fb7so892099a91.0
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 14:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793223358; x=1793828158; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:date:cc:to:from:subject:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C4z0s5i6m6Cm9i1YXIjTnLWI0y9WJTId6/68tOJJcxc=;
        b=pwtLorr4ZSTYEkgsBfp7+V13FyLjQTm3LA6tohObPwEli7b7vmLyn2NuNESi++sSe2
         Av9ACPBpq01hF08Q3O+4qTnY3S0Z7voggBlqQTqjhWiamknyT9QpMsuLisb3X2eQJ63/
         wDKYo9TrUexiA/x0FXeuIEPQhDJaiCOlDlb6U8mJjHkAL4d4YN/7lUcidHl7JytvnUj6
         ATjIQ5JTYYzNW1d4R75O9wJOZXyy95u6gSDeF/iOdwdU8fDmvl+2giXbWcdeq1K04+zs
         OSabpfd41PyHT+UMavMxX5dS5GBT12aMV9B0TR3kr8ZTee2v4VZYDgrsVyhRQXJtyrY0
         6+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793223358; x=1793828158;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:date:cc:to:from:subject:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=C4z0s5i6m6Cm9i1YXIjTnLWI0y9WJTId6/68tOJJcxc=;
        b=fxIQ/3fl7Vvnoh7PkGlQI18Fcv6qub2K8sONFv7WdtvVq6KF4xkzhnY7fBBuGMQxrc
         fmZ3V22I5DaArCjRy3UIXl+mupyFt3YcaURd8QIbgcfqKxqIWjfnssrtg2NcHfJcJdSC
         i/rb2wXkDzyK+zVqvnvAVv3LU4gVbw5zKMkndXDzTKhlsE3hVAYFdR/cq4TKmCYjUWJi
         u53xhu+wTCVc4SzL3/2xGdzaAIg05cq1oZg/cEH1RsEk7q69hRELH1d750hKHGK3Ok/O
         dviqTa7AOSG0/XpmKJtaoqkKSdkAtlwwiw6FkwYnQyTOkWjgl5HTF3wVuOvMfltxs6ks
         hI9w==
X-Gm-Message-State: AFq9FYKCIIgz39umRAcoZnIce6QdyiU68BLad//3tvaKzOIf2AjRnbTL
	/eW9ysEFi99ROgjGOxA8F7xE5F2y5WErtRvI/xhoxIp7tNdpXSmsN8sT
X-Gm-Gg: AYBFou2vDN6OejP1meD1CEsfDseCFGrxXFf6Orl7aMs+6aP7qFJyn8ssPsLq7yRZlHb
	M+F6V2LoW6WwAK3PS1U7YNy0/kmpT2aD6cwGUiQE9/FfeHtaUD3q4OUcrHdIjCT+iV2AsTyrMAw
	cZmc1W9b1ax3HKivp9+o8gtmpucR/6mq5T1WQBF+8XiYMVrdb4Bd1TTlyOVBvpXtbeLcy06Fc7/
	NBo1D3EAT1nnl24OIqwTQZIXm+5pyuEkrI+0p9WvmUAgDwoyzs9UtBRZA079FCMkUH2waKJkSy9
	U7M/f5ugZ0ULw5GmLQiUj4zVa/R0Kk2XT/dhfMdA2ibIibzqfs2SpwRK2zUAxbFQa2eI/I58FSJ
	2PYqfqHdOJHSHEuq0PNDlyY8OtmHCdLeHeQWSjf2ZbsPRf0CUZMLmFcsruJ3wPYjobsLv6WIYvl
	noP6wh06M+cb0A+PjgjTJxqilITls2V/ciLWrzlAmb2eXHR1zwYHlNNLmwWSXBVCYDRjuDHgU+3
	xyqKLT81sQVb1iHOWaMfnDiBAZbbtIKax2n8+J3Vfq5I3/1JizPGqmfjNlNW5L3qAVWo+vLmO97
	79d7dJwJcGrnqzOP2wCfPdH8qqDqHBJuws0S0yaR59AdlNQLpw+F/lW6Px6rGP9GBT55IluZ0gC
	pRBuY/Zlp0CPDHHi4xFb6PuXN5SUBj+JDa0WaxAaM2gAEzuE=
X-Received: by 2002:a17:90b:4a82:b0:3a7:e126:4980 with SMTP id 98e67ed59e1d1-3ae5824d38bmr2824046a91.43.1793223358073;
        Wed, 28 Oct 2026 14:35:58 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c1:38c:400:22f5:2de:b9c3:f27c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e8fb1ddsm1079873a91.5.2026.10.28.14.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 14:35:57 -0700 (PDT)
Subject: [net PATCH 00/13] fbnic: Fix BMC filter, FW crash restore,
 teardown and Tx flush bugs    
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kernel-team@meta.com, kuba@kernel.org, pabeni@redhat.com
Date: Wed, 28 Oct 2026 14:35:55 -0700
Message-ID: 
 <179322311834.40667.5383039334126572422.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Review of the "Rework the BMC state pulled from the capabilities
message" and "Remove BMC routing rules when the BMC channel is disabled"
pair, d261a371e3b7 and db99b6fae21c, turned up a number of bugs in the
surrounding code that the pair did not introduce. This series fixes
them, along with the order of the ndo_stop path, the mailbox teardown
and the Tx force-flush.

Patch 1 rejects a MAC address attribute shorter than ETH_ALEN from
firmware, which was read past the end of the attribute.

Patches 2-3 and 7 fix MACDA allocation: a missing break in the
fbnic_sift_macda function, the all-multi wildcard entry being handed out
to the unicast and multicast lists, and the multicast sync ignoring
entries waiting for deletion.

Patch 4 retries a failed MACDA sync to firmware instead of dropping it.

Patches 5-6 close the races between the service task and ndo_stop and
the rx mode work: a service task pass that runs after ndo_stop no longer
restores host filters for a FW crash or a BMC update, and the crash
restore takes the instance lock.

Patch 8 rebuilds the BMC rules from scratch on every reinit so a changed
BMC MAC set, or a BMC that left while the interface was down, does not
leave stale rules behind.

Patch 9 drops the write-only active_slot field from the FW capabilities.

Patch 10 puts the BMC MAC address array under a seqcount so the service
task does not program a torn set while the mailbox replaces it.

Patch 11 suspends phylink after the datapath is taken down in ndo_stop
rather than before, so the Tx path drains with the link still up and the
stop path mirrors the open path.

Patch 12 waits for the outbound read and write flush armed on mailbox
teardown to complete before returning.

Patch 13 disables PTP completions along with the packet drop during the
Tx force-flush, so a dropped timestamped frame does not leave its
completion to be reported to the host without a matching packet.

---

Alexander Duyck (13):
      fbnic: Reject a short MAC address attribute from firmware
      fbnic: Stop sifting into a BMC slot once it has been filled
      fbnic: Keep the all-multi MACDA entry out of the address lists
      fbnic: Retry the MACDA sync to firmware if it fails
      fbnic: Don't touch host filters from a service task pass after ndo_stop
      fbnic: Take the instance lock to restore filters after a FW crash
      fbnic: Let the multicast sync reuse an entry waiting for deletion
      fbnic: Rebuild the BMC rules from scratch on every reinit
      fbnic: Drop the unused active_slot field from the FW capabilities
      fbnic: Keep the BMC MAC address set whole across a capabilities update
      fbnic: Suspend phylink after taking the datapath down in ndo_stop
      fbnic: Wait for the outbound flush to complete on mailbox teardown
      fbnic: Disable PTP completions during the Tx force-flush


 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |   5 +
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c    |  53 +++--
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |   4 +-
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |   6 +-
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |  20 +-
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c   | 218 +++++++++++-------
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.h   |   6 +-
 drivers/net/ethernet/meta/fbnic/fbnic_tlv.c   |  21 +-
 drivers/net/ethernet/meta/fbnic/fbnic_tlv.h   |   2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  |  10 +-
 10 files changed, 225 insertions(+), 120 deletions(-)

--

