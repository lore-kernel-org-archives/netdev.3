Received: from mail-106109.protonmail.ch (mail-106109.protonmail.ch [79.135.106.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5A7125A0
	for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 07:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771745477; cv=none; b=E/+v1/PL8wUIc4/XO5joaqy8l6ybUSCEE5cLWmhxtWgSuuTudQdovXpH2CLQzzppFHgLaVpAvRlGEX58XR0xjI9pVQPdY3gMrRQeZHM5sn0bS6oyNDXrgYLwzCSo5BQkAyTd3qgTTJFuHj2hoiE2tMtV4ReFMmZJKRYGTb8y/qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771745477; c=relaxed/simple;
	bh=GVeFrkGHd+zJB2J+eJLlpvF6zIS8Ee40GUUMdEit+MM=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=cZEFBqYAxBthbaxDy8Pz+U5ls+W0671bxmhyqbwFs1rrFVLaI1Vees3tMKvRGFcJDUbJ00JwRZZ0/Cn7MDmdcd6ZKFsDY8QoD8skobA4/SKz1ia1QtHzYQEA+tiLC52dh9AfpYiHHfzVaqmL9DPib6jw/aHgFmbmjGnOlswxjjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=HT6A3GUE; arc=none smtp.client-ip=79.135.106.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="HT6A3GUE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1771745083; x=1772004283;
	bh=GVeFrkGHd+zJB2J+eJLlpvF6zIS8Ee40GUUMdEit+MM=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=HT6A3GUEdkgaLJGiffeeMLiag+fuXSaOpFWgVBxOrZNQiYi4DuWSUqiabW2MTf20/
	 BrvT9IqJFDeU8K3/x9kGLj4QZhrTJt/CdSdhPSdBkzoolHYgkIUQH97duHFfOZakwN
	 sEOSenjnEAIBSPBDgkNpSRynfq7X19kbsIvG9UG+fQgRXE0ouYB/KuEvpOaStap0Lu
	 TXpA70pWqUNhFGcbK++0kAQdpKYo1x1yETcM+q55rx4BWFFheaYuD68HOobDdEmCvm
	 jxOP1IaPsPUp0HPRAgIgWOnDMcx4kPDCOxDR7Sg1ljlxRIExrQRXhGkG/aTLKt2R6K
	 gb6ipnYbcV7Jw==
Date: Sun, 22 Feb 2026 07:24:39 +0000
To: Linux Networking <netdev@vger.kernel.org>
From: Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc: "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Subject: Amazon: AI-assisted hacker breached 600 Fortinet Fortigate firewalls in 5 weeks
Message-ID: <-3q0eXE17223SaU-QV1MZw-y7iuKwRWlAEDY59A_b3dTEOt2tAUFIzm7fStrtegUi2ltMFj3wsEY7WbcilJwlX9K86JsWQLmmlRktcRaKRM=@protonmail.com>
Feedback-ID: 39510961:user:proton
X-Pm-Message-ID: 156dc498a4f6fce3f4934976d951f66845ce1cf6
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Subject: Amazon: AI-assisted hacker breached 600 Fortinet Fortigate firewal=
ls in 5 weeks

Good day from Singapore,

Here is a news article which I would like to share.

Article: Amazon: AI-assisted hacker breached 600 Fortinet Fortigate firewal=
ls in 5 weeks
Link: https://www.bleepingcomputer.com/news/security/amazon-ai-assisted-hac=
ker-breached-600-fortigate-firewalls-in-5-weeks/
Date of article: 21 Feb 2026

Thank you.

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Extremely Democratic People's Republic of Singapore
22 Feb 2026 Sunday 3.24 pm Singapore Time





