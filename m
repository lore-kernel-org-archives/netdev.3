Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2BF44D696
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 16:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780505576; cv=none; b=WB9nNUQVVNukFhRaGhWSoMYkecrl46k6wDbBG9nLNy6FLVhsKv0NgvHyRgN+mk7QG9yW6CDT2krZyyzCXhhybjsKzRPLk/pqpvLcQt9Xa4taQhTTmlieOtZZSfBcNKMzvK1MSqrbtAdAZ3DD4jzclmk6/NM7rsTH1q+uR6ip4qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780505576; c=relaxed/simple;
	bh=yfF7RMfFdw06+Jz0bfgKvLOWZz3Jg5V//OUWt61idJM=;
	h=MIME-Version:Content-Type:Subject:From:To:CC:In-Reply-To:
	 References:Date:Message-ID; b=EveXuqgWm3QVinxBCWnWBMYbSBsESe5QmCgZpzhDuKpEoflTqb42FLFN5LCag687zc5ckGFXCg/QcytRzbe7Qlx7cmbapEMk4c8gcDT1Qu0A2nUCiJM8E4muunfqzlFYc7ojbhrqWt3aH83G4VZZaD+rNZplGS3GvLKPEcrdozI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Vjg8N7bN; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Vjg8N7bN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1780505575; x=1812041575;
  h=mime-version:content-transfer-encoding:subject:from:to:
   cc:in-reply-to:references:date:message-id;
  bh=Zp53lq8ckUqXmbXUKyvx2zMGiwCcsDDn+qDyATKk6jA=;
  b=Vjg8N7bNFpYMzIJj1gGq839eNAO2c0W7bEC/vs8MHgFUgHPmA/OeBjRD
   ryPiRpCPVAfsQrdwewiTa3uGC6PFphEZYPyJp+ilWU4wCu7DKUt/g1W1n
   V9Vj8H/YDcFA3O8FYlclM6+QgpFMv1H/tWUla21uqUyZ7lMZb+T2Eeulb
   g3VqD0hkS7lWZn852ftI0eZUDefUEr5jtgIWfYi0rY/NvLqZhBZFzSCLV
   0izzgaE7gkCm9rISH2P5aksCTzmyBjNObqNS1RUQZaFSe2FUNS/25LLMB
   4mqSgYuUpgJ/tPOIMybYIwJ4rrnS1ARsIbGPMmO94ExCqbJ0WbrYhvO5U
   g==;
X-CSE-ConnectionGUID: An43yZ8wT6eYVt/Ngg96ew==
X-CSE-MsgGUID: YAKiJjiWRfeOjxlAlSBlhw==
X-IronPort-AV: E=Sophos;i="6.24,185,1774310400"; 
   d="scan'208";a="20909992"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 16:52:52 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:6227]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.245:2525] with esmtp (Farcaster)
 id cc8d6ef7-ac36-4325-8920-7cc673ebab41; Wed, 3 Jun 2026 16:52:52 +0000 (UTC)
X-Farcaster-Flow-ID: cc8d6ef7-ac36-4325-8920-7cc673ebab41
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 3 Jun 2026 16:52:52 +0000
Received: from dev-dsk-akiyano-1c-2138b29d.eu-west-1.amazon.com (172.19.83.6)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 3 Jun 2026 16:52:48 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ena: PHC: Add missing barriers
From: Arthur Kiyanovski <akiyano@amazon.com>
To: saeed bishara <saeed.bishara.os@gmail.com>
CC: Arthur Kiyanovski <akiyano@amazon.com>, David Miller
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, "Woodhouse, David" <dwmw@amazon.com>, "Machulsky, Zorik"
	<zorik@amazon.com>, "Matushevsky, Alexander" <matua@amazon.com>, Saeed Bshara
	<saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, "Liguori, Anthony"
	<aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>, "Schmeilin,
 Evgeny" <evgenys@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt, Benjamin"
	<benh@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Arinzon, David"
	<darinzon@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik,
 Ofir" <ofirt@amazon.com>
In-Reply-To: <CAHfVqdVpvEF6PXCqSu_Of6SkQY+Uv0b2C1K-0xrgV3Cyg-RcqA@mail.gmail.com>
References: <20260603065532.13260-1-akiyano@amazon.com>
 <CAHfVqdVpvEF6PXCqSu_Of6SkQY+Uv0b2C1K-0xrgV3Cyg-RcqA@mail.gmail.com>
Date: Wed, 3 Jun 2026 16:52:41 +0000
Message-ID: <178050556194.6110.12215070734658422269.b4-reply@b4>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: EX19D033UWA004.ant.amazon.com (10.13.139.85) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On 2026-06-03 15:20:52+03:00, saeed bishara wrote:
> On Wed, Jun 3, 2026 at 9:58 AM Arthur Kiyanovski <akiyano@amazon.com> wrote:
> 
> > Add dma_rmb() barriers after both req_id completion checks in
> > ena_com_phc_get_timestamp(). On weakly-ordered architectures,
> > payload fields may be read before req_id is observed as updated.
> 
> sounds good, note ena_com_reg_bar_read32() missing such a barrier,
> probably can be done as a separate patch.
> 
> saeed

Thanks Saeed,

I agree, will spin a separate patch for that.

Arthur

