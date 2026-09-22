Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EE6492E48
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 18:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790102199; cv=none; b=Ei6HFeW1b4FoQME3GHAIHVml+y1pBWIpBeJWAwO4UDaau/E9dhxCM+JufO5sHvyfx+mm8bK+Dc/1N5W2qLGLgrUzxmKs09rsL30BxPJ8rpsQcOnAn8uUp1doRi7AlY2C3VlJoh0IyQi3zsfgh2vWdz+wWUC0y8FC5x/c0O5G4xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790102199; c=relaxed/simple;
	bh=pzaa95eKTIpKOawS/ljYzfkzuYgonZm+DzgE96OTi5E=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=jSqT78gotHINsHMxfem2d1TN0Wze9cCWnwKbR/NK9/rqwaMv7/Hvz2l0jH2KabLL1/H6eldgLW8Mixq6xqs+CVezGIty+2H3jaRMpUT5DuMdfpqzM1c5B2rh0ucXHFxivIgqTNLxvqAyTE43GnhT6QGnbrNkjqAXWhd6pajgYj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBQSglaI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBQSglaI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4315A1F00893
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 18:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790102197;
	bh=7cm5O6O7EN9qeF3p9Ia+d9wZRn8ejEU5FlkkkFX25fo=;
	h=Date:From:To:Subject;
	b=ZBQSglaI+Xlx2YDZVfjCiKKqmYqWWpDsHwaaCUb7P9XgwEw12JzxHvsK8GhQJACZk
	 TorgFaGkA9hsoLwqiIFX86mrYaXgjk8Njm0Kt+CbZph+e2TzOiWf2ld4SLED/2nHH0
	 /W+MlCEHQ2FhM9RYMfWR7S8TeA/VDBFLNPh3E4w7Cqg+q+kKc/xTTC2JGIj5Dwrb0a
	 +KN/5ODL2hQbOg8VS1kmec78q6mdDcxG3v+Aj6sRcRN0Kss+UH/DyP2XV+kKVBClCF
	 DWkfvQibBE76YbBXljybeyiAjc7c5TCNeN2/pJiSvuKCsL1IpPPjw62oov0UtQ9Vfg
	 4S0CRKYOAREJQ==
Date: Tue, 22 Sep 2026 11:36:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [ANN] netdev round table meeting notes - Sep 22nd
Message-ID: <20260922113636.2783779a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Nebusec bug tracker:
 - https://bugtracker.nebusec.ai/
 - any MAINTAINERS email can log in, feel free to request access=20
   if you're an experienced contributor without a MAINTAINERS entry
 - automatic PoC and patch generation
 - needs human review and polish (like all LLM stuff) so maintainers
   encouraged to look thru issues relevant to their code
 - issues auto-closed based on what lands in the tree (not just
   trailers)


NIPA perf testing

Stan:
 - Where do we place the system stats - NIPA or in-tree
Paolo:=20
 - Using the CPU metrics is quite noisy, the accounting changes between rel=
eases
 - NIPA side would make it faster to change
 - Some of the naming in the patchset is confusing
Stan
 - Let=E2=80=99s keep it simple and start with NIPA
Martin
 - Regression testing is quite difficult, it's not easy to define the
   representative cases
 - Ensure others can plug in their regression tests
Mina
 - We need to avoid over-optimizing for trivial benchmarks
Jakub
 - Would be great to record our preferences about the test quality and
   guidance on what we accept on some wiki page=20
Willem
 - How do we store the thresholds, the expectation can fluctuate quite=20
   a lot
Jakub
 - Automatic eval in NIPA, same as we do for test case vs HW NIC gating
