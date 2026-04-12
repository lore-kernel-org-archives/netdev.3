Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99CB2EAD1B;
	Sun, 12 Apr 2026 14:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776005643; cv=none; b=Jui7OLfHGuMaLYplZ746TS3eq7ZJNOwz6Lc2r0qmkpWBlZdCNtL43CjuFJxD/ZECELs4ebkNAghprhn7xs3lAP2ieZDwSZlgPFWVIY7xjFrOR9fhTb1AIhxV+UjFpcpggynfPmsq95ucvKEoEaSDu+Ie6fTcILSEfjZPXo/ufrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776005643; c=relaxed/simple;
	bh=hYhMNiSVMu9YWHVhPVRMrBFQV3jTqJLs7Miosi0BkO8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VGlOY1RTduEVJQMMYIYXJ/KYj+tm8Iv7nQlg8oY1F2hcGtwxkFWwlephtO1T1J3YQ6KmcIeXbZIZAr0rFNDD/O1CIo/kvMGECGdDSf3MMMlhIVw6k2lI9Fe6xsYQ2u71kSF4KoAhiNZxcgUigaoCXQqCdnsj/y6fUxNqrAzu/Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHZqcMBi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHZqcMBi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA3EC19424;
	Sun, 12 Apr 2026 14:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776005643;
	bh=hYhMNiSVMu9YWHVhPVRMrBFQV3jTqJLs7Miosi0BkO8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EHZqcMBirrWaPT/iTHH9lRJ1HuoNL7HHSQ2OL+IqM7wS/+NLv3apgcvkdnptpAjuQ
	 p/IGAA+sZId7dLLetl9wvsKafKzT9VDzD1QzoBywR6lcYF8E8/uXwck/P5Euhm1pUU
	 /lyqs4pcbGUpfxZt9tR/+utQSd9EfAlkvjsWM/rAa6RHX89Tczpw5FpgyzTc0n+8rC
	 chu3QNPwWDNCgAK5ZmSdKcW2baBeqO+t6agKhHAFWNjbttFeflGtWPqak7i23BKd8a
	 S7voKNK0fff1r/yhQ0Pvmnk3MGKxxlEbwlSUQiSYp8nwlgyLA8FmFORigpvnhkkQcv
	 uIhCbLULAfOrg==
Date: Sun, 12 Apr 2026 07:54:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Frank Wunderlich <frank-w@public-files.de>
Cc: linux@fw-web.de, nbd@nbd.name, sean.wang@mediatek.com,
 lorenzo@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux@armlinux.org.uk,
 daniel@makrotopia.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [RFC net-next v5 0/3] Add RSS and LRO support
Message-ID: <20260412075402.2eda04d3@kernel.org>
In-Reply-To: <trinity-1304ecb5-9a3f-4e37-b2c6-bcd7f35c2921-1775995067670@trinity-msg-rest-gmx-gmx-live-579dcf886d-nkpds>
References: <20251219151219.77115-1-linux@fw-web.de>
	<trinity-1304ecb5-9a3f-4e37-b2c6-bcd7f35c2921-1775995067670@trinity-msg-rest-gmx-gmx-live-579dcf886d-nkpds>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 12 Apr 2026 11:57:47 +0000 Frank Wunderlich wrote:
> some time has passed without a single comment, so i just send a friendly reminder ;)

You have a lot of people in the To:
Could you clarify who you expect to action these patches?
Patches are an RFC and I suppose ain't nobody got much comments?
