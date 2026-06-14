Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FFE1FC7FB
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 21:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781473693; cv=none; b=GeuB+VbtdPJKILbNINxTnLdfnEbFf9gbwqGQmVuu5J0Kah09bofhXPa1kMF0RvEcDEU8LGdE1TOnPmbzhK8aBfSeiMO9J6zjAoXjmHS8zaDJlOBenpvOtQ1O84CvT8H0mjPUS72W23NetkvMtjHznvgvwLBYzesVViGJ9PCF+TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781473693; c=relaxed/simple;
	bh=dh9OFZ/OYOxg2E9E7qjU/cxffU/qwZ8W8t9uZNGnR7w=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=C8hTVJnRVLlUCeXO37xy4IGVmIzJQ+aaFlgGPnz7pZm0hDxv1ZsQpsttza+yOoCHx0eu0Z9Dja2sVPqL0nc+xy5wj08BUC5i2TFFlYexyHY0kOij6Wuxj8++dXPhIRgiW4JZSySjaLb6pqecmsFV1vuRdFtwAgri86qTxAXzRrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGwdeafq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGwdeafq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8111F000E9;
	Sun, 14 Jun 2026 21:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781473692;
	bh=FOjtmSzT3RN4Tr1FeLf4o+G99sWvrsBZEtIXPtsCwyI=;
	h=Date:From:To:Subject;
	b=dGwdeafqB2XGev+98jQdMr4LsTswXNS9LJJf72QpuSlLhxCKcgV8V48AAFb8tSmJh
	 +/fwe8R+lpUwsev+E6Qq8GT8WgMbFVhPKzQo7VD7GS2h/thZpELQOgTIymc7NR6t1s
	 S4JISqkxlk1op6Z0Twn2eKkQj7uLpfE6oeW0ly9s59/RIL4TaOhMRiPHF3sL5OPRhm
	 HQkdaWc1zdjsdb/V0AEMzK7f5LZ8sDlBTjGxLT5kLJ/eer0oLquFj7KInvX2B90GxM
	 Qz+QhV/4V3Odoain4X/GJNoumtNlCtdt5cFNTW8CH1rgLKXE29/v+CFRGmZlljOl8E
	 BglYFjQxkpP8g==
Date: Sun, 14 Jun 2026 23:48:08 +0200
From: Helge Deller <deller@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: e1000e: Report link down after "Detected Hardware Unit Hang" ?
Message-ID: <ai8hmGQmXQu64Ld3@carbonx1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm regularily facing the known "eno1: Detected Hardware Unit Hang:"
with my on-board intel e1000e NIC hardware.
Since none of he various tips on the internet helped, I had the idea
to setup a master/slave bond networking to fail over to another NIC when
the Intel chip hangs.

Sadly this doesn't work as intended, because the link of the intel NIC 
isn't reported "down", so the failover never happens, unless I manually
start "ifconfig eno1 down".

My question: Shouldn't the intel NIC ideally report Link Down if we know
it hangs? That way a fail-over should at least happen, right?

Below is a completely untested patch.
Does it make sense that I try to test and/or develop such a patch, or
are there things I miss?

Helge 


diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 7ce0cc8ab8f4..c6edcf4ac032 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -1157,6 +1157,10 @@ static void e1000_print_hw_hang(struct work_struct *work)
 
 	e1000e_dump(adapter);
 
+	/* The NIC hangs. Force link down in e1000e_has_link() such that a
+	 * failover can happen */
+	hw->phy.media_type = e1000_media_type_unknown;
+
 	/* Suggest workaround for known h/w issue */
 	if ((hw->mac.type == e1000_pchlan) && (er32(CTRL) & E1000_CTRL_TFCE))
 		e_err("Try turning off Tx pause (flow control) via ethtool\n");
