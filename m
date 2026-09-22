Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BCB47A88E
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 18:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101338; cv=none; b=tRF3Xuf//0ld1Rplaek+2U0+8NiE1QaiiEmymSwJfAvv9Jx5Ce1Xk2YfS506vBiFbmGHyuBnYhSyN/D4jd+TMduIywW6H5j9Ods9BpxBcQcMCfj/xFypfCA+IjCt2xLovBqytLt0P2wzvlb0bkp+LsmCltt1GF12gpPdylNeHes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101338; c=relaxed/simple;
	bh=MRtD+LvKA8k0qh23e2kYmI98CWVJaQioVM2C5FlEVyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BJ2ijauEwyT2rOpglJGqkH0a6voL79FM4QS62PB218UjF0DtJcFDEPp/Zx7iDaYJCC8MTBVklLe46t/ypfJ6p2N8qg32cqo/31Z7Aq4F7mDF4x9+R+e/+CU6b+13SXHv174+bAa6Qn1jHiJac7ZuENfXi3fN7ioMKN/OX2FGQXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFHs2ii4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFHs2ii4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B986B1F000FF;
	Tue, 22 Sep 2026 18:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790101337;
	bh=MRtD+LvKA8k0qh23e2kYmI98CWVJaQioVM2C5FlEVyQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gFHs2ii4Co6Da2jt7D/KyYwpJBbi53RXnRY5R/da8ix0ZZYilXCal1cSPlnZ+cHHh
	 a0qeH1zSXn4PKmRAT9q14m8OYYrsQ9cvZQ6nDk+yWwfal+Sl3LM6uTkapXUs7phgFk
	 Z0SrcyruNu1nQGGCSKcDKgenqpQ85If0BNfEzppkaNZMV0pv4me7lOFofU/wykr9b+
	 4TcdLFq9OBRy8rqdRmH85R7TsmiZap1BsahX9/nOH+TBDbLIwaHWbMDPI5LeVZNmqJ
	 /1UdUIByzZpsoMKgwxFttEsZao7X+H4/8f+2V4Ap7Jd9Tg8Ja/1oCmr+IemMWCttQn
	 EHNYlzjDDpOCA==
Date: Tue, 22 Sep 2026 11:22:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Grzegorz Nitka <grzegorz.nitka@intel.com>, Arkadiusz Kubalewski
 <arkadiusz.kubalewski@intel.com>, Intel Wired LAN
 <intel-wired-lan@lists.osuosl.org>, Maciej Machnikowski
 <maciej.machnikowski@intel.com>, Przemyslaw Korba
 <przemyslaw.korba@intel.com>, netdev@vger.kernel.org, Anthony Nguyen
 <anthony.l.nguyen@intel.com>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, Petr Oros <poros@redhat.com>, Paul Menzel
 <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH iwl-net v2 00/15] ice: E82x: timestamp processing logic
 fixes
Message-ID: <20260922112216.41e6f8cf@kernel.org>
In-Reply-To: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-0-e55b692d0e6b@intel.com>
References: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-0-e55b692d0e6b@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 11:02:33 -0700 Jacob Keller wrote:
> Subject: [PATCH iwl-net v2 00/15] ice: E82x: timestamp processing logic fixes

I think we need to reconsider iwl cross-posting to netdev.
I can't get my unread email count to stay under 1000, and
I don't think the cross-posting is really bringing much
benefit to the community. IOW only Simon and Intel people
look at the Intel postings, anyway.
