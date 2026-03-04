Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C781EB1AA;
	Wed,  4 Mar 2026 02:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772590880; cv=none; b=RlXWbhEBHYqqxogmNjTrikrgZdtTJCFkl4s34/OUPDtbfJ1v2KlpDra30diCYEbyl7EPbI/yJFl03ZWADfKMQPBNZg5N0YZ1MXtYIQmTV9+J8B2otYnugnRY5+kzxtH0Zxp/ZiZSwhTv+EdsQpiIbIy1sTQogoDOkXS9e5zQBKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772590880; c=relaxed/simple;
	bh=aZ5pVNJJLI0Jknu1MKY6nQm77CHpWY1Pd8TetJWtmfM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VAyVjrZEs/f0dJKT9rjLYDxOHvR2QOy89wcnoTduuVbapiAC3tWhgt2VLdMeBvCJuBtGVds/z646z/JTWL7gtPuPsaGHtQbYptjDpNajQWgIippH3Wh+BjyeuKvY38g3csEQ8/n6+kds/SJ4fMNbFvCTXlcJEa2eXEckJbOScaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OlqokNza; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OlqokNza"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF41C116C6;
	Wed,  4 Mar 2026 02:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772590879;
	bh=aZ5pVNJJLI0Jknu1MKY6nQm77CHpWY1Pd8TetJWtmfM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OlqokNza8xBlCo06Rmua98huElwMoromZeEe38MG0AE1sPIVNu3llryjrUmBa0ENQ
	 BFh1LCxB66f7nowIKXfCvfMwP0BPndL7ZaKbsisg7lpkk7VoJyv26G8UDvKSyCL83G
	 OXDsrFKAoxKXRdBLFZQsKkLyHEXBAYm1SJC4SCxIo4ee04MhQi1JZivaOBz/VuDAJU
	 tuKOBOUiQ+GCeYMZqwrb9nomcRfhGWS1s2J7bJasOwrEYF5lSAEyU8GFnREbS0RVs8
	 JNrZPnZJjma98N6jGOKpcWZb+1XjcjNmeBL+k+Cz+rws1FKhvdiKjsLNDrh9ifc/Bb
	 k84lVSJ1axt8w==
Date: Tue, 3 Mar 2026 18:21:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Cai Xinchen <caixinchen1@huawei.com>
Cc: <ioana.ciornei@nxp.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] dpaa2-switch: Add depend on FSL_DPAA2_ETH to
 FSL_DPAA2_SWITCH
Message-ID: <20260303182118.4c3c1968@kernel.org>
In-Reply-To: <20260303013814.338989-1-caixinchen1@huawei.com>
References: <20260303013814.338989-1-caixinchen1@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Mar 2026 01:38:14 +0000 Cai Xinchen wrote:
> When CONFIG_FSL_DPAA2_ETH=n, dpaa2 cannot be compiled. Thus Add
> depend on FSL_DPAA2_ETH to FSL_DPAA2_SWITCH in Kconfig

Please add a relevant Fixes tag
-- 
pw-bot: cr
