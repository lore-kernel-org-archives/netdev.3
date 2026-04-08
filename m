Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA9B37883D
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 07:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775632623; cv=none; b=aKuRAqj+e5e1sscr3nJhWMShHyFLsoQVsTFXNC+rU5dxm3iOAs9ZNL1UU4kD9nTLFBSxa+SI9Cbk5DSrGGYh7xZEdwIe8TII0J9Rsc6wdq83/DBPC47Fo9pi+GSAUTZVk0g32doZlDFmT+LbBwHRwCLNF1vtGjDJgIfdHiGdPiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775632623; c=relaxed/simple;
	bh=n4Edos1iFDf/N7bitwT+Paf9vJ3CRZC1B9LCOXtd8Qg=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=GTZrcBVFFUnM1EPiVAO89aFpwe5JCYsvci9NuI6tXZ2vukmFZ0lwhRuWvRVMZo0tnhmwTIUosV6C2/fRNZA9jm/07/YU8gF9SooacuHFa4k/kGeS09VUnvfmOJ6D37DwnfVYj8zBcZwhwAIfZLHnx4DK+Gj4f8rXIsWeVFJm6mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=TQWsSb4f; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="TQWsSb4f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1775632611; x=1775891811;
	bh=n4Edos1iFDf/N7bitwT+Paf9vJ3CRZC1B9LCOXtd8Qg=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=TQWsSb4fYAyJqj+zKvIPtyqpHsDl2+uN0e+fGuZEbxqsFt7ZMnUPZFZnGZAn41n8I
	 sllGN74+DNdgRXhLuIDnilt8HblMoD1MkG8xN74qO2Do9gc0e7owKJnhKtqxzL6qB+
	 mCdPy0f45PhQ0ng3gzA8H3d9zRPOV+Fm1lDdW5V2BqmlgHeZ7bjHBOyOxXCWsrY0fr
	 mz3Lr08ryCv3fuiCniU7JP6+mIlp8LVGdqE7BeOdFv3S2572SOoA8leklvZg2UTGpY
	 V41K+wRJCFaGXILxf1p7yr70uu3+M6k5zfkY3aCrRvFq6+pIYH0j9B/dEvzbegPnf0
	 johU4ScKHdxDw==
Date: Wed, 08 Apr 2026 07:16:47 +0000
To: Linux Networking <netdev@vger.kernel.org>
From: Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc: "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Subject: nmap scan command in forever loop to trigger Snort IDS IPS to generate intrusion alerts
Message-ID: <rMHbalrN3Ljnsq2TlMjGStV6UaZLiOQRTgfJBLQIw0Xq3ADERvNLCr1mtQ396ntLlBp9wJ4wHim5lIpVe0lxUhjVCnopiLh3fdZfb-PXktU=@protonmail.com>
Feedback-ID: 39510961:user:proton
X-Pm-Message-ID: 87b459fa794f09d21fb6e6887a76364449b39d6b
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Subject: nmap scan command in forever loop to trigger Snort IDS IPS to gene=
rate intrusion alerts

Good day from Singapore,

Running the following nmap scan command in a forever loop will trigger Snor=
t Intrusion Detection System (IDS) Intrusion Prevention System (IPS) to gen=
erate lots of intrusion alerts.

# nohup sudo bash -c 'while true; do nmap -sS -O -p 22 tdtem.duckdns.org; s=
leep 1; done' > nmap.log 2>&1 &

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Extremely Democratic People's Republic of Singapore
8 Apr 2026 Wednesday 3.16 pm Singapore Time


