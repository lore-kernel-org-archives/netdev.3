Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3A6372EC0;
	Sat, 25 Jul 2026 21:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785013971; cv=none; b=exJ55mOVBZm633N7gPCVc7Q3OT4RPlDzNA2ERkv7RT5Yi5SVMHc0H5U1jM8D3hJov8dh22uOgd2ABS6dzaNRcmwtFKZS1VYvhN88/lY32pdLAGKCkK4Lxcjb4NrNjGoHk+gHIxz5xscogB85sHKYSGhsm7w9etGo/A822tsRV1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785013971; c=relaxed/simple;
	bh=FX9NIm5YWBXiDktf7ywFAIUCm3xYG7hpaumCyaghDJA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ah7OnOr1/TJCpCCHmL+NHUOSnBEF1Cyp2rAqKIaK7vWt/NumIJPkpmS8CUmZdE2HGYSTbOHpH82WfOua+n2E1lysfkZjLVzv85iEmWijLZablWNl7/Hcugx+2TiRFyRAMZmE9oCXSEeGKEOCc87mPLKALtP/kBfUebMnkBuZUok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=johnericson.me; spf=pass smtp.mailfrom=johnericson.me; dkim=pass (2048-bit key) header.d=johnericson.me header.i=@johnericson.me header.b=EEXBi9bM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rbk1azpl; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=johnericson.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=johnericson.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=johnericson.me header.i=@johnericson.me header.b="EEXBi9bM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rbk1azpl"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DB76B7A0077;
	Sat, 25 Jul 2026 17:12:47 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-05.internal (MEProxy); Sat, 25 Jul 2026 17:12:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=johnericson.me;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1785013967; x=1785100367; bh=FX9NIm5YWBXiDktf7ywFAIUCm3xYG7hp
	aumCyaghDJA=; b=EEXBi9bMqkthUBpEGzHmTIR6GecjIVfGNbocJ2ekmxtF1QrJ
	YCk0K8HC/bfnw7Hjp65zsi9Z9bkSeHJskp4vD1MfjaHk2tWrLABJ29/U5oaZmWYa
	ML6F9ZoonA2ruJ9DU6sQpPl5MFe+n7+DC2on4SbK2qDUSB1hKRenGOhOEf0hcisL
	ulIzDOoQgwe3SS2VnY6xk/9xwTy/NgKjS6eYMzQqQYUXIAcB4eTJT8DIylHoaTLV
	aojvo4Q4XUGv2+boaLUmfj5CpkHSc8d8VcVMuU19a9O6oSLlFracF5B+jteT5MRh
	EqvSKjOFa+DDmD9D8O3t/fdSQ6+6GG3xvwGpCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785013967; x=
	1785100367; bh=FX9NIm5YWBXiDktf7ywFAIUCm3xYG7hpaumCyaghDJA=; b=r
	bk1azpl6CZJghpcxYqf0LLFRKUBAaIG/MbqJ1wATkU/5himw5hSh8vZk6o7pPl/W
	NQA5YNDf8A7FP5BuPVD00MCIov60NUsPVld5ua+iRmtAhDFtJKjHnagq7Im+Wv3x
	hq+UU+fN28WSlvUH6D34jbeelZeGTBqjOyWBIAYvcpFlpJwRhnkUgZJXgfit33FU
	OdiPdCPyz1Q/kBMnzGmo3xClQOAyekEKDKFSdXgRPUbCI6wdyvQuFNtzVGKGMQhO
	QdBgRYLdPrB0ToYpscGk/GJ+g8Gv95hyQTt3G9Sw2TfmrT8w6dJSMJZVincqvezT
	W56lnpQpHZcFnEWLKbRcg==
X-ME-Sender: <xms:ziZlamc8ksJf0mUjkT87P9o_fjWI1ST11spb-QdyRfnkaaxLE2NlLg>
    <xme:ziZlarAVCxezuxPxStNmLSFbKe8GCpg7-V3FdCPe3KCHmfTN2nwI688WkMUQkC59g
    PrsD27HBvSx8iJ7zFgEqF3xogod_j_Dttwn6RO4l2-YSUwV3vgaxYQ>
X-ME-Proxy-Cause: dmFkZTEpCyMsZEWpSsNFPF+kgizHT3Re0ugMYizZncrH6bNs1IjphdUfSIBtpaK3OANKFh
    GenQ3lBh8VlYMkMQ+/KutfWFsTEvwrugIHFcQdNOQw6ChL6qEzY8Q7cSrCYxnPmJoGeeUA
    UH7nolEaNvDFm6aUjpFKxizpbEM54JA2IueZDFDxdZ0Ke3bKi+H7zAJQ6hnriEZlMN5+yH
    j2OBqSAtoW3w7NM+SyEXH7sGVABY09lI70Jk/hwSXiC2KaVmFU627Vn0Bm6PIutLFPmFo0
    NbYUNImnER8BWhB+ld5BOQI+aJ1K9EIbGVh7CeJxH2LsmENlN+/KaxamgTBRtobhftBEfg
    CTuV3Vk3UD5mC1h7Mann7zjf7xVzdKxxTuSko3LJyWe65TDGaxwtpuKWOPxx/EIO0XQHwt
    9hmlPcW9s5Oe0GELlR5N1akzJ91u60IOc/7J68C3najfBvsGpcaNfn9qUdd1bsnNwqNL0j
    Gi6n27oOWg/oez69DDWO7G+9mdXb8HteiEh+Yu3YEZ3tOC55AIZWe0NNiyhNaSFCC+ro9Q
    IURSrNjK3fBfJbhkAKGVctvpFoMHAtaG21FVEfMOLEHsZNbNyNT8dV40n0eJZ7M7QCDXRb
    xs+IASVIVj5m63ihMgjD7Jws3hrPuDYEFr5ylyYRAbCcDyfL8tdEa+ssi3xA
X-ME-Proxy: <xmx:ziZlaqTIen1jgDrs0NORZukHkfwdNi7K3tKNjWmDxFFM9g-F_hbqpA>
    <xmx:ziZlascRZfreF2QlZzp3xHTPFm0paFFMXTyd64b3pKQamQe9KxJ7_g>
    <xmx:ziZlars-Y9qIGzc2w9haPzuA0wxgO5Dtxp5sD8sQV7fYzmKZF2Z6xw>
    <xmx:ziZlagKrx8KFFXdAhLJwOXXUpx1G_wSMFWX0WmE0-JtrGpbb24KgIw>
    <xmx:zyZlapr53DXWK2g98wzAN61_VOZdlSL1vSCUtouGoe0wQfghQrW2UEvv>
Feedback-ID: ieb4144f1:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A3C802CC0086; Sat, 25 Jul 2026 17:12:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AaLgTCfSr8ho
Date: Sat, 25 Jul 2026 17:11:54 -0400
From: "John Ericson" <mail@johnericson.me>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: "John Ericson" <John.Ericson@obsidian.systems>,
 "Kuniyuki Iwashima" <kuniyu@google.com>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>, "Christian Brauner" <brauner@kernel.org>,
 "David Rheinsberg" <david@readahead.eu>, "Cong Wang" <cwang@multikernel.io>,
 "Sergei Zimmerman" <sergei@zimmerman.foo>,
 "network dev" <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Message-Id: <879b72ff-581b-49b9-8c7e-de94c42257a9@app.fastmail.com>
In-Reply-To: <20260724150909.130726ef@kernel.org>
References: <20260718182903.2295560-1-John.Ericson@Obsidian.Systems>
 <20260723091248.6acaa173@kernel.org>
 <acb8cc56-6473-4910-9367-8c3c0d75be78@app.fastmail.com>
 <20260724150909.130726ef@kernel.org>
Subject: Re: [PATCH net v3 1/2] af_unix: fix listen() succeeding on sockets in the
 wrong state
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Yay! I think these are my first kernel contributions to land.
Thanks so much!

On Fri, Jul 24, 2026, at 6:09 PM, Jakub Kicinski wrote:
> Oh, you should probably mention the net-next follow up under the ---
> separator or in the cover letter next time.

Ah OK, yes that makes total sense, happy to do that.

I see that the two patches have now landed in net --- yay! Apologies for
being a novice with these workflows, but should I submit the follow-up
to net-next right away, or should I first wait for some sort of periodic
process to occur where net-next gets synced with the latest changes in
net?

Cheers,

John
