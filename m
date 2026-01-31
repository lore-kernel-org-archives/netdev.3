Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB58727AC48
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 01:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769822013; cv=none; b=X4oqYqo5kxDBL86WbHoMReRK6UNhJ1UTpG9o3s9QbltwjO1Ab7Tzs1fDYiT6Z205GmLtQGwasznQcfrnLEJjY77utOEFb3TIxXfQ3YsB6uW2XESy7oo+jPV4nfWHcT+W3IPZHf4rt09iUcDEm9e4JRm64TUTMVZSkqYG6ntdVwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769822013; c=relaxed/simple;
	bh=evgtStCu75itte8DFZOCQRwGzrdulcJ0CsxFLzCzYuY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BMnc8nQjAhn29Kv6llKDntkq3RwZ/h94BkBakjJhuwzCaYnNhNzVGsALwxlaoKylgzhjkUVeom74/lUNfmQZ1QCYElpWCcCSwu7VBDUBMRWv0mDMzm8u9L3Pku1kIR1uJbW1MxzaRm+h7ayV7c1iBbW3mLJETZ0umGvwD0hXO0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IId1qtpG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IId1qtpG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E022C4CEF7;
	Sat, 31 Jan 2026 01:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769822012;
	bh=evgtStCu75itte8DFZOCQRwGzrdulcJ0CsxFLzCzYuY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IId1qtpGfJn7lUn8mfTX7RHbRzYOksTBfxDGw8RHZzVV59hgsML5Eykkv+SztIIay
	 Kn1MWLOx7LSN+ax6GmnaTPuVCusOIjvrUiZz3w45YI9TRKju8J89xo4AszMfXgq9tD
	 b+5pFQu3DLnYJ+GhW3SxCbcpuEuMxmbXzh57ToTcqg5ZrCgT2macvFR89CN9DUdWmK
	 W9HHSjGsyfFa9p/YksjAEwRQ74wvTwUdCTERjPmM1a+uQnnvHqouX3BCOAeMDZ4yI+
	 E1ZwHsYgvESEs6wCfuTNYLlT80q+MGj5nYcL1EKtoJWA3NZKs7TZSmFkW+hYMgnmvo
	 9VWbkrnItSUyw==
Date: Fri, 30 Jan 2026 17:13:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>, Vikas Gupta
 <vikas.gupta@broadcom.com>, rajashekar.hudumula@broadcom.com,
 netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net-next] bng_en: fix misleading error message for
 generic firmware version
Message-ID: <20260130171331.70172109@kernel.org>
In-Reply-To: <c19fdbaf-e179-4bbd-b51e-4de154233776@oracle.com>
References: <20260130073055.1609162-1-alok.a.tiwari@oracle.com>
	<CAHLZf_vxzcOpavJ-rNUsmi3XQ-NAqmWBvy2MRgGb2A3iWFHFHw@mail.gmail.com>
	<c102db6f-c676-4bb9-a1ee-3a43b35e6290@oracle.com>
	<CANXQDtbG9cXkzAPoDF9p5sLon=4aOrKJQvojgbieyhQ=+8mWuA@mail.gmail.com>
	<c19fdbaf-e179-4bbd-b51e-4de154233776@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 30 Jan 2026 19:10:13 +0530 ALOK TIWARI wrote:
> >> ACK. will send v2. =20
> > Should this be a candidate for net with a Fixes tag? =20
>=20
> I am open to either approach. It does not break functionality, but the=20
> current message can be misleading so I am happy to tag it for net if you=
=20
> think it=E2=80=99s appropriate.

I think net-next is perfectly fine here
