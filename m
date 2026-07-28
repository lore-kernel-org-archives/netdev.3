Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205174657CD
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 19:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785268501; cv=none; b=QmaRV65/td9KKagxgaQzdTK/Y9FPtY7vu6JZBsQeiNit5SBYoCTOmmXn48h2QKSlTuh0ILbWr82vELXDabBEof8np6vLm1JqcCxwv/le+7Kz7kJTpzWSMlBRT2LZnYeVLJAFzi47hdYYVI9GPEbzePFc3cYTLMaGuFRqZwujSQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785268501; c=relaxed/simple;
	bh=n3EYPtrMrRdsxm3rnSxzdrs7up587yCyVm3C5Pr/lio=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=SEUNPC+9OPsbzZtWVBGrvnOxwvJ+8h1dGg0MYfTNidIuFQ/K6gdA7Ve3pJce3lrMWELfgFZhPTxKhd03iaciVlyP/jRl25iw20G723Vh/AFhs47lEoVgYGAgBicwzKh98/J/HsSvuhrXsxtEnj6abStEgpyNh9C9AVDuznfWQv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LH/yjDFJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LH/yjDFJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5BA1F000E9
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 19:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785268499;
	bh=e3Y8lZk5Q8qKFwjrL2QlNBU1ySXnhZa5KSFkOAEatbw=;
	h=Date:From:To:Subject;
	b=LH/yjDFJnW39A4gCfIYN4/faRrTh8iKyadAUKGyUR0awP8U8J7CTCc00lp/ga3Izm
	 ZQoJB6llZ+ghFBIw4a7RZ+6oNA81etZ+S0ZiQI/Dm8uOLoPXf5mnDfw1Fj5ygdh+cR
	 WgNbyg+GYKP+s/LyrhZuqyQLZ2fkBV4AEDaV3+XJ1w4fjsG8M7wPtP6BKPB6D7oweG
	 WzG4NfFhc5yIH4bL1jS6yBjq/UEC668+gQmEka4HmVa+ZKwvD4tUdynhMC9if7uKy1
	 y5I/AR0rJ5ooJrXPTF5474KGwBdbWsjwCUF7DoEIADdvJqHyFklK3qv45WAlUcPok0
	 jszZPVoiyTe6Q==
Date: Tue, 28 Jul 2026 12:54:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Subject: [ANN] netdev foundation TSC meeting notes - Jul 28th
Message-ID: <20260728125458.5f243bf9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Present: Andrew, Jakub, Johannes, Paolo, Simon, Willem

Academic Research program
  - Moving forward with proposal with a view to announcing publicly

Logo
 - Shared feedback on drafts, work progressing

Conferences
 - Meal sponsored for netconf attendees
 - netconf update: https://docs.google.com/presentation/d/1Ak7yiE7Avk5mENd_=
yK_wE7V1zZE-yp87VGveB9jeHqM/

Lab Update
 - 9 PRs NIPA from Matt, help while Jakub was away, working well
 - Containerization progressing

PHY testing development update
 - Monitoring progress

Wireless CI running on Netdev Foundation infra
 - Working well =F0=9F=99=82
