Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808032931DC;
	Thu, 24 Sep 2026 16:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267288; cv=none; b=omVRPqxtX7FauluHM14Bm4FYZC/aErNNHQx4He1kIj5Na9u+Fyg/0gv7bYp3CyRs+pQo1OBPvr47Mlf3yxnqQJD7VfHpdOzb6pGYgUqoDdG9NpkyLEHlzTYYX0BTye8S67IiEe3IEd4We0qjuioECc7RJ4tIy7l5WBEtSkw8teM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267288; c=relaxed/simple;
	bh=pPSoOJugKNMAyKKJahZhyIvwFGHuI3CFaDyU+NXn17s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJ0szAvBLd4pOBJl/jSRPa2z5B3PQHOuf3ixvpq2UEkFCjePJQpamzaSt0PbJEmRrd9tkzkxVqa5RK0AYFZSEkgKtGpkqi3GMs1ttU3rroKmTOWZbpyrY6QgO3lzcwu1WhksS+EmNZbqhu6TbzNdXVruBS0FqlKhJfn/KiEwITA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=p1cBsPdV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s7Dr8VSK; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="p1cBsPdV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s7Dr8VSK"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 8D506EC0193;
	Thu, 24 Sep 2026 12:28:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 24 Sep 2026 12:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1790267284; x=1790353684; bh=KqdYesQ6ptmwwm6LSTY7gkDMoNj3LuVL
	leOnwtbIWNw=; b=p1cBsPdVAAMbEgRrDByVPARx8QpIXl04otq+DI79FYW7gONT
	aiH7em4hLoPp9Lpf/IHSXAjnPIj9ruCkRA2pqSQyhhKmIUhLLuBjsTvkGpTvt1E/
	rT3NX2SWrQGxsZlklphTSGi/SGFldL3YS1DHrCAoX/CQzyydXe4OZ5BsfsI3eoAb
	FZyUjZ8BZK65i2gtKGtv9zbxrFUi1byHSlWbAQZPQnrhbXNF78bDISHf2ftVp48H
	0hKZ8mCM7KnYgT5EF6DZXaWA/9tCABRRv9TAwIRKUHgoeAQ3NmlMbFM7VU0peNqk
	tZoVHq0AqNetpaxTSTMb7Ui27zQQNcTnv32EkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790267284; x=
	1790353684; bh=KqdYesQ6ptmwwm6LSTY7gkDMoNj3LuVLleOnwtbIWNw=; b=s
	7Dr8VSK8CoOZyA0tyLSh5vtTbpugYujbsSsdoC0eBLiKKnpGkvHxRQgdNB6857t3
	999t4VrG11YIJRvN2zMrSzxwSAHRrtpsfmvGYyrR7PORUzqZeSojawDqZVPB8MVE
	OkYBzN93BYZC8vrgVS4q1F9AXV4J57N6Mnh6KoajL/34koLJUYzMwLqbqOixvIRl
	T8IDoW0dpfg4LXUuCp1yeA+CM76xjKKDx6y2nmrQ0idWoNKOjMYKqMlgnek/S1/3
	FsLDfxaeyS8d6M3QJHNNCoFm42oVY4tNnuBif1HYcSZ54eooBLuJSeSeXysE6z6c
	1yWb6T7c62ydIRDzyvmmA==
X-ME-Sender: <xms:kU-1aj3nO_23x2rRayjyGwocQi_6N-XLfRXy-WkbxaoKqq2af5LRAg>
    <xme:kU-1amrW-ZiIDroa5ZAnL9UfSYJGusCVlpgYOatA1ZaiwBqsa3zSWeRacSiU6bEuN
    Ko2dnNjcRcFTUDM3cAFUDQRAfWM-b28vzFiXCsbt0xsY6kTLaq7c1_8>
X-ME-Received: <xmr:kU-1ahAHnG_12bkfxOxqISvjXQZEbf-1-mBNzT1h5q017TduZ3J3464Y1d8Q>
X-ME-Proxy-Cause: dmFkZTFhwHdmJGobszBA7IYHVtW/Mv9QjKEIbTDExmIxLOju3KJrRvwbAl93Bb6DUPRVop
    zs5H+zaLlFGLsWP4MGhJHRz67kX04BLfitMOO2bB8li1TppLwKc1VJSEycz8hbnOToc2ax
    Ly0ufPR9EcaRbFGjwN7Z3s7abet1nWe5thBG2qJ2cafBGe+oq7wsup6wVi5t4D4+uUCQkz
    IO+aS2MPdkr95qz27OU/3nAb1nVlKVmLeG/kXCm9w/kIriZinfHwIwn3E/xrCPP0KseIqw
    b4McqlLWjl0XTjesFGs8VNc30T8Pd5XXshkyq0fUPaIiaa3MujgVHc8QPJTAbykY6QVgLT
    /mLY2hBIO0U/xdfgCFYJHc/bnxHJ2WkKmHchQgpyyLYbiOt1h2Oikjy5cYLH9DtECJ/saf
    jf6ODutWAeQyIHu/Oqhw7W31KhnGGXR6mVJox8V4YY9ZPXLiWmWsybdQONa3Xkh5HcrHOO
    k1mHCjzv4Gl3YSC3IJq6O3K5b9duo0ParS6eFSRDY3RgruMVlcf2PlWIG0sP2JF/0g9wuT
    O+0SxYYP8hWdaEVLMarEn7YJxKfWvHbB7E61PndaMRku2kPmHkT/KMZhFfWU5KrjeYn+lN
    II5897zYql+pUY2uqULXfd5s1bTT2sP4yAHuVFewnzgESYVmjWBS37V4ZZLg
X-ME-Proxy: <xmx:kU-1avryQlnjdEqIdAUxtadPiauBCzfeqBAmWpSRrxGj6IBnPEiE8w>
    <xmx:kU-1akAle3lnew9yuyIaFlVONZKqPubQ2d5IdrevyTM_ybjPLF-1uA>
    <xmx:kU-1aiX8rOCMKXN7Iwb6TgO0skRuhblEwJZxdGvXlsShj6tIGXfndQ>
    <xmx:kU-1auC9s7eeGQjc2XnO3-Kyc4Bss_tlLYGankW-Fxwu3-puoFHYuQ>
    <xmx:lE-1aop1iFmnFGFbrcivC25eahUXYCDIUymm5n6jD_11UPeOU94_ELuq>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 12:28:00 -0400 (EDT)
Date: Thu, 24 Sep 2026 18:27:58 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: Jaeyoung Chung <jjy600901@snu.ac.kr>, horms@kernel.org,
	linux-kernel@vger.kernel.org, eulgyukim@snu.ac.kr,
	davem@davemloft.net, edumazet@google.com,
	herbert@gondor.apana.org.au, kuba@kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	steffen.klassert@secunet.com, zylzyl2333@gmail.com
Subject: Re: [BUG] general protection fault in espintcp_sendmsg
Message-ID: <arVPjqf1LPVKWRK0@krikkit>
References: <20260819155349.3555804-1-jjy600901@snu.ac.kr>
 <15476f67-1484-4af8-bc5e-ce32fb24607f@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15476f67-1484-4af8-bc5e-ce32fb24607f@linux.dev>

2026-08-20, 16:22:19 +0800, Xuanqiang Luo wrote:
> Hi Jaeyoung,
> 
> 在 2026/8/19 23:53, Jaeyoung Chung 写道:
> > Hello,
> > 
> > We found a "general protection fault in espintcp_sendmsg" on Linux v7.2.
> > The issue was found by our own race fuzzer. We have not analyzed the root
> > cause, so we do not have a proposed fix to offer.
> > 
> > To reproduce the race reliably, we applied the delay patch below to the
> > kernel and ran the C reproducer as root inside an x86_64 QEMU guest. The
> > crash log we observed, the delay patch and the reproducer are all included
> > below.
> > 
> > The following kernel config options are required to reproduce the issue:
> > 	CONFIG_XFRM=y
> > 	CONFIG_XFRM_USER=y
> > 	CONFIG_INET_ESP=y
> > 	CONFIG_INET_ESPINTCP=y
> > 	CONFIG_KASAN=y
> > 
> > We hope this report is useful. Please let us know if any further
> > information would help.
> > 
> > Reported-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
> > Reported-by: Jaeyoung Chung <jjy600901@snu.ac.kr>
> 
> Thanks for the report.
> 
> I suspect the issue you reproduced is the same race that Yilin Zhu
> attempted to address a few months ago:
> 
> https://lore.kernel.org/all/c30b645074a1b379e0f7fe297f917c66137d9964.1778464688.git.zylzyl2333@gmail.com/
> 
> I have added Yilin and Sabrina back to Cc. Sabrina reviewed that patch,
> but as far as I can tell, no revised version was posted afterwards. I
> do not know the current status of that work.

Thanks. I made some comments on the patch and never got an answer or a
v2. I'll take over and add some tags for the reporters/authors of v1
and of this thread.

I should be able to send it either tonight or tomorrow.

-- 
Sabrina
