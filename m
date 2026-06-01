Received: from mx01lb.world4you.com (mx01lb.world4you.com [81.19.149.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3EC2BE7B6
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 18:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780337599; cv=none; b=izSuIp2Tz1LYaGEJ6XMswAcZeFv2Q7FKbRGORrfhMFPMTNqhVwHtNH5cCLRMkiEr9m1VF1bL8tIyJX4/64as9sU1zakIzBTW+M5YBYQes8FZvqqOk8HoHONFbUgIaPVrIJ6PUeBFWkBFfgBMHnrjg67H1gG83wHA6I0EG6ZZ8Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780337599; c=relaxed/simple;
	bh=9q183NFC9fS2JbtBL36Ugl1YrAbf8Ci2YCyn/eMtdUU=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=UC2SidRAKtlwXxdhwdHEtZtjv0OTDeoCoR/Ib68b3sSQO1EdaP8MRXlHxx3o4/eulSB6wytlB4irlnU+++NXNuuMoz5Y6NsJXKlSlsGj9oCyDGkU/Pwwz95XfqbFLsKVdcq0Xpvhop7i+dRAIMy+EiOi4tdaXnwzxviLVLhMP3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ciaorelated.com; spf=pass smtp.mailfrom=ciaorelated.com; arc=none smtp.client-ip=81.19.149.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ciaorelated.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciaorelated.com
Received: from 89-26-47-193.stat.cablelink.at ([89.26.47.193] helo=[127.0.0.1])
	by mx01lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <info@ciaorelated.com>)
	id 1wU78W-000000005iG-0zmg
	for netdev@vger.kernel.org;
	Mon, 01 Jun 2026 20:13:16 +0200
From: Dogan Karaarslan <info@ciaorelated.com>
To: netdev@vger.kernel.org
Subject: Open source social media project from Salzburg
Message-ID: <93e04133-cf26-3ce4-9ccf-fafa48fbcb0e@ciaorelated.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 18:13:15 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-AV-Do-Run: Yes

Hello,

I found your contact through GitHub.

I=E2=80=99m a developer based=
 in Salzburg, and I=E2=80=99ve created an open source social media project =
focused on communities and meaningful connections.

I=E2=80=99d love to share it with you. If you like the idea of an open =
source social media project, I would really appreciate it if you could take=
 a look and maybe star the repository.

I=E2=80=99ve put a lot of heart =
into this project, so any kind of support, feedback, contribution, or =
simply sharing it would mean a lot to me.

Here is the project:
https://github.com/dogankaraarslan1/ciaorelated

Thank you for your time.

Best regards,
Dogan Karaarslan
