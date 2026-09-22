Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B322353A85;
	Tue, 22 Sep 2026 00:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790038735; cv=none; b=E4f3veWj+HkV+K9daorMlP1sLp+PYaVFtMe6e2IEuUNQH9voEMDfnxSeDKMuc5FG3KEa4Inc7E7qBJmJQuofNJ3Sl/iGPKVbSzpINp8EM82sOVJ/zoek05efoV367eD1aO2i5MgZJyw7LA+PJ7FJRw3rg4UibPAKyHt2h4w3OIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790038735; c=relaxed/simple;
	bh=os1UCE2MKdMueOC2E/T7Ay2jx4YXx4/vhmTazjxgp7A=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PkEkc9snwyT8TMvbCdjXYvrYObc6vjR2UTLqpoSi2Xy8qanYQ8U10ZLWorfp638GYsEM9K/UcAC+dM+oADtWLMI16xToIwqGt1TzAXEdgLoxzPw0HaFG1at8XcMzW/JaYxgEUv+NO1wLkc+U87I0/bh3YPvKle6WLlHoOz3q66s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1jahuUO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1jahuUO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 751ED1F00898;
	Tue, 22 Sep 2026 00:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790038733;
	bh=I5y5Z9zNAUtlBytZz/i5E64bzSKp3EMlZHq8r8qSnBQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=B1jahuUOn4Ed7HTQMKhKJ91gKhrkqYStFEB+gWZEFxmpwr+bWam1fbD7GKorQzXj7
	 fWIbQezUuRy5l6yJQTugnK5mpYZ/xbRHZfqY6ErBEvtjgpMxbE7kKVFz4lloT/rZvr
	 ARR66WagTvWxO430SSwAJfIod67YPQWRkMQVily+kfKiBvKbrTe1fRYxvj7cHLAmxy
	 y2svXWVX7H6CepvhiN08qUkt0xJdV7/2VtcCmzCKNnT5uxcpIMIvup1fOvE5ZBPYhc
	 09vLTALU+p9OD4Uqt9RQPUrjY4tQICQSV5L0T5ATM2v04Ovx2cYu7Ur/LmdaiSHvw2
	 Q6JfmbyP/Vccw==
Subject: Re: [PATCH net 6/8] net: bcmgenet: validate Ethernet address in
 bcmgenet_set_mac_addr
From: netdev-bot+sashiko@kernel.org
To: florian.fainelli@broadcom.com
Cc: netdev@vger.kernel.org, cursoragent@cursor.com, opendmb@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 zakkemble@gmail.com, horms@kernel.org, ryotkkr98@gmail.com,
 linux-kernel@vger.kernel.org, nb@tipi-net.de
Date: Tue, 22 Sep 2026 00:58:52 +0000
Message-ID: <179003873206.2160803.89291738197160435@kernel.org>
In-Reply-To: <20260918000732.276506-7-florian.fainelli@broadcom.com>
References: <20260918000732.276506-7-florian.fainelli@broadcom.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Submission hygiene: the commit message of "net: bcmgenet:
  validate Ethernet address in bcmgenet_set_mac_addr" (2c00a16cb1e7)…

--

net: bcmgenet: validate Ethernet address in bcmgenet_set_mac_addr

This adds an is_valid_ether_addr() check to bcmgenet_set_mac_addr() so that
zero and multicast addresses are rejected with -EADDRNOTAVAIL instead of
being programmed while the interface is down.

The only comment below concerns the commit message trailers, so the diff
hunk is not quoted.

>     Fixes: 1c1008c793fa ("net: bcmgenet: add main driver file")
>     Assisted-by: LLM
>     Co-authored-by: Cursor <cursoragent@cursor.com>
>     Change-Id: I1cae9178ff2c9243510556f42a194058c10aea7e

[Severity: Low]
This isn't a bug in the code, but two things about this trailer block stand
out.

First, the Change-Id line:

    Change-Id: I1cae9178ff2c9243510556f42a194058c10aea7e

That is a Gerrit-specific tag with no meaning in Linux git history.  Could
it be dropped before reposting, as described in
Documentation/process/submitting-patches.rst?

Second, there is no Signed-off-by line from the author or from the listed
co-author, so the Developer's Certificate of Origin is not asserted and the
patch cannot be applied as posted.  Could a respin add the Signed-off-by
and handle the co-author attribution accordingly?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918000732.276506-1-florian.fainelli%40broadcom.com
