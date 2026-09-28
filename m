Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com [74.125.227.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EA94E06EC
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 16:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790611924; cv=none; b=Lx28eQjrJ6p/kAzutqAqwWuypvE0hhXnnUZXpfRnPVeJYCG9DrbjWfl8pWqIM53S6MHin8rL6qGEYxBMuPgyCv2f3F+noy2xrOa/6vtSSJIlxgWmsZdP6M1CNs6AagG/HgLgZS4amWIo49FqcImKwGxCvGpHkhPVe920Q2XsnE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790611924; c=relaxed/simple;
	bh=+u/Kszoa/CD1L17rghxS5i14UMkSxZRKavd/pSldBZI=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=J/d3wC5NX9qP+foRWXcS58TV1aD316vfAhgmmYWHwQXZ57DRermf0E8b+2R0bnmY6iFxASq0VoKWdVOFM8qrclkxhBtGWL2I5VaG2S5+IkRAXaKSo5Ranv9/jug5DgflfqqlZsEpOflX7LU/vX5Q8cU104zP8X5V8KiCmvhQvJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lileQOTC; arc=none smtp.client-ip=74.125.227.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lileQOTC"
Received: by mail-pj2-f39.google.com with SMTP id 98e67ed59e1d1-3a49896dd9dso5899a91.0
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 09:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790611923; x=1791216723; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:date:cc:to:from:subject:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xc2PB33N/06TV7GXr3ScQJABLp35Rn57hNyQ8bLV8dw=;
        b=lileQOTC0TD0WAY651xtpS2vjp+Zr9Z0um7rQvq41fYHKXODj13Hgmh+KYEnXMd+SW
         TYEIlCoz4HN1F2KiOjqWGwDOgscMM2xNqPNkq/jazYYiPh/ACpQ1E5aCtsOFVWQRzVvf
         18l6rErDV8FPp0mbHKogBakUyIF4xXgF2tj8fkGvCsfcNGKB1KjbMi97k5c+frRWOn0L
         VhsWwqd/GWSbGGXQuiDOAtpkrqPYwNmEakIPbhUREOQf9nKo0r5ur4jvbj7snaLAgH7d
         NdjiXeGkuJii0yxhq1p18KIRaphJ5mjrwGSjJDAEnE2JJjnGV+WeYN+nP+JT6PH/ZKaW
         DSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790611923; x=1791216723;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:date:cc:to:from:subject:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xc2PB33N/06TV7GXr3ScQJABLp35Rn57hNyQ8bLV8dw=;
        b=jbOav0cIQu2fZXM7JfluknRqFe5BtY2d2j6cAdEPNAgIsk9ZZFa4y5m3m/qwu22UFH
         5r37fUuptZTaXoqYl9R0aEsKZbQu9B0oJtwqpdDQUIdPZESBkoaiZLWB0Qj6+UaTnUcM
         ralQTwUObDXevoDwwZoUGSGduVIVG2xCdKRFreTlSy4iXEMMwJEm4GW+HB6T5BILijFp
         rpRb8gKVR1bQ5PaWh8UUA+6csPVBRNiD/FPYj5IkufJu13tJfN9rpVOafYURvLL9ig0n
         nWJuOKqzcKlVZdl+LO98OSeCNjM4WP5Xkl0W4gynmhS1MBBzqnH+ZhBv3gQoFYmgOgkn
         IBCw==
X-Gm-Message-State: AFq9FYJ7x4PnAo4YetbL0NhVQCJJQupGHo7MosKIsoPObbzFhpftXosB
	mMit+qCu2ZAWkCM3wwz9zg5qZ+18XNmpmGtN6ZlCHT7CaSb6c/b1hG/K
X-Gm-Gg: AYBFou1cXdBdyF4mUZ+HzglUh+21fLKuNejxOQF1VUarf3JGOB0ZAgRt0U9I8m/p6Lz
	vRHD/fauPMHfb+3b/lLDCFHNvm1LovhRo3SREiHtQ2Dnw76OYn62TmwG6eN7tKQpUP9q9Rs4IwF
	ILqqpczBIjSfDYCh2UAk4ehw80YOaZjHjBTXLczkuS8ufkVMHjwp+8+GMzQ8m1KkR91mJ0wFn5R
	AedWEHppmZHB5Nn+yDUWaOsb2L0wdHdFaNe98CwLoVNUQse5yj0fQiPsNmnJ+c71AomT/xUQN23
	m/9wN0FOS3HGlOq5PVL9f6e2QQM8wEv6VQRhRHti2yGnF+sstje/DCYDSSpcxIRxO5JEKghQ+xQ
	/r09czCLaep6iBQXSEIEWduwur3LEkhmepciTydiT0+7na7HVOU5KAFSJqCJ+aVz70WmKhrQFhW
	eOyUemXixKCFbMYiPzoHt0uschQH1nP1eK1q7o5hRR5p+HChU7JWtYtT/55UqdXJ9n6yaBDkmsD
	Uo7kNljOJaXXnUI/arcZpCRyOXs7Wg68iZyUu4cb4lSk7rM8nC1+djaU0NCoA3LxNYdwQ6GDL+i
	8TuGFwGfp/35me4TLA==
X-Received: by 2002:a17:90b:4cc9:b0:39e:6c68:fd91 with SMTP id 98e67ed59e1d1-3a098b8fe02mr7839699a91.38.1790611922722;
        Mon, 28 Sep 2026 09:12:02 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:d680:cb2f:f831:8497])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a498d0123dsm18411a91.4.2026.09.28.09.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 09:12:01 -0700 (PDT)
Subject: [next-next PATCH v2 0/2] eth: fbnic: Update BMC MAC address handling
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kernel-team@meta.com, kuba@kernel.org, pabeni@redhat.com
Date: Mon, 28 Sep 2026 09:12:00 -0700
Message-ID: 
 <179061185153.414394.13396934246780284806.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Update the handling of BMC MAC addresses on fbnic, and in the process also
address several issues identified with the changes. This patch series
consists of 2 patches.

The first patch addresses issues found in the bmc_present and
bmc_tcam_reinit handling. It started out addressing the fact that present
w/o a MAC address was flagged as an invalid message. However, we ended up
also addressing a potential race in that setting bmc_present and
need_bmc_tcam_reinit could potentially race against the bmc_rpc_check. To
address that the bit flags were moved to a state bitmap and are now handled
via the test_and_clear_bit and assign_bit operations.

The second patch cleans up the BMC MAC addresses in the TCAMs if the BMC
opts to disable the channel and the FW notifies us of the BMC removal. By
doing this we can terminate the now defunct paths through our NIC data path
to the BMC. Similarly with this a potential race was found due to recent
changes that had moved the handling for the TCAMs out of the RTNL mutex and
into the netdev instance lock. To maintain sync additional locking was
added.

---

Alexander Duyck (2):
      fbnic: Rework the BMC state pulled from the capabilities message
      fbnic: Remove BMC routing rules when the BMC channel is disabled


 drivers/net/ethernet/meta/fbnic/fbnic.h     |   7 +-
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c  |  78 ++++++++-----
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h  |  19 ++-
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c | 121 ++++++++++++++++++--
 4 files changed, 179 insertions(+), 46 deletions(-)

--

