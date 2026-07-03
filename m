Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E6D1A6835
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 21:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783112879; cv=none; b=dwWPnu2ocEAXQV+sG0l64N+kn/uf2KLQESTSWE+/IWGpY3TEBdAtDbtTC/tPTBCkHW0tRLT78Evljnwi7bq83Er3Q0dTJRAA0LcR5gxJ/1gtIxMz+JYyu2UJ0KXU87dXHR/qGX+9a2dsK8X/ZcLTijz1es84JkquJvM5sZFESCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783112879; c=relaxed/simple;
	bh=1sorKBRD2b4m1rJXgJXcaK0DhH6ZZ6Qfw05mMzzjleQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=s/5ymL7Z3xmtCqhG8uncdJLFfwAGrR2mzqqRgel3Ds6ZIMQOFrlTcQ1QWYZjX52uWX9+QxSEU+li5y+o2geuevP4QQ9N26EMz5fgU+RmSU06gD0TJuIjqPjY/xjr7t3f6cHLZHho1aQX5IlM5h3qvZQEin2cTf/ucDuuJ98ELgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISyLy6f6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISyLy6f6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C72641F00A3A
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 21:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783112877;
	bh=ZCQzVRq7RDq/oObpqUf5q9jdWP4fyXfNyYa/7bjpj2w=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=ISyLy6f6j4T8s3E3v2S1rZuoEk67yFa8VtsetjFdYNVBAjaD459ZfKMtztfILD4qP
	 zsvwt+UZQkbgYlqHM29yAYs35n6lswrNhiSV57pkuAhPde3TrrN4Ki2VwoY195T9TV
	 iGDivlQSxY4VgTNNY/3qPp5R65cAhZAtcE9WprYkpG9rzDrm7p402Rw7mdqITULW3/
	 E+F4qaGWX2tBEe6VpUPHMB+QR/yGRBl59oelkPBDPYfqdw4XkDASd5RolMY21QJpMG
	 DYXZTIgqM2RJRPrU2LzQJBuaeSrl8esEWbKqm0zkjTpxXRj/Z2m72x9Oq8MQu4YFeX
	 QpZZzmAAVP9FQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id AC5BCF40068;
	Fri,  3 Jul 2026 17:07:56 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 03 Jul 2026 17:07:56 -0400
X-ME-Sender: <xms:rCRIaofL7Uf6IinzwndAXyuRLT5x737cvWd_wPXxdj_ki8DqUXgLXg>
    <xme:rCRIalDGHdPHFsNwLrBX1P32WL9FUqXidcAx52CXKiUC2LEcQ4bmdvH_nUS7k4J1t
    r-LPgm24mDhGQ23c5I5YLbYFeFhanWzGr4UyZR3RGSeypgg25wbQRco>
X-ME-Proxy-Cause: dmFkZTEex9BRYtMeXlxNvYMgkqN6XM/B5Tw6NdpXSdPZDEwjpMhFx+vUFIMWeA+Fra8G3L
    ExwANTmIc5unmAAwxv8dOp4azozzMO9cmOnjC/x7vwxLt8TzjlRYggO1M00aNey+FfQpbH
    yz4vqqNDowZLUDPEWOmnlgFAL5ugLadDsb8kI3+4dppRg2mcxSBY29+yAjzqddPlOIk4Or
    kaeN81CO2CFOt4HFPxv2Ebo8QfGtVW6nMXXjoj53yxP6kGsaxKYugnKYGAv9Ri6MPAG1M4
    oQRRXJKL4zD5uTyVAfaEhghZ9F5N3loMf1zJJBPwadNg/6YKF/20U++tlEtfGXaW5p/nqZ
    rPvUZO3mF+IZbrLhEhA7cgxnijN6itJIP5prLzHZ09bqUrIy4cR+kE70y4xXMK9DywEEiL
    Fm+1kcCZ8lRYAkv23eNuqY9soboRjdQYZBuLPtMMYjEm0r+i2c9sbL89oNZ6i2J3JVjksF
    LElLyJJrIMqwCnLBNHzYOGessyMNkybbAniSYmWDB9ASfvF5+n6K9Alsv7px+8r9j7T6Ac
    cIaDVRVEiw/tMJQ56FFBbCwY9NnIeeKGJYMAFoPFXEsH0LETXupxeWfMgJ5tFi6dwQiOVi
    w870eWcWUJPlbZhot//vYuf6gvoLq3BaObwCMjt+lGlOLiW/9qpVGQYPtT0g
X-ME-Proxy: <xmx:rCRIalxilOHAdtlN1EUqDVy14FxLe-oRPnxscssWVgbZNg0PN9FIBw>
    <xmx:rCRIavSmRUYTCZOgDiEHtMEwcED50I3Y2rKTG6vv4rfS9xwWmYruUw>
    <xmx:rCRIal_c1Sgj-EyyMHKx_sSfZJdT_CkxtQpEgwbPKMamwvXhXXxsBw>
    <xmx:rCRIalssWPFUY-KWhDMCkRkvMzEDXUU9wsZIxjvlfDgRA3jBBYh6XA>
    <xmx:rCRIalP1C0seIlI4GVM0OR8oGOSbcosjmDOzKWldyEGzanjAL3hc1fIU>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8E6EC780AB5; Fri,  3 Jul 2026 17:07:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AZOB0wyakXwF
Date: Fri, 03 Jul 2026 17:07:36 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Sabrina Dubroca" <sd@queasysnail.net>
Cc: john.fastabend@gmail.com, "Jakub Kicinski" <kuba@kernel.org>,
 davem@davemloft.net, edumazet@google.com, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>, netdev@vger.kernel.org
Message-Id: <7103d652-1e36-48af-98ce-4849bafbf7f2@app.fastmail.com>
In-Reply-To: <akbdFcQP7oTp_n3s@krikkit>
References: <20260630191551.875664-1-cel@kernel.org>
 <akaoXcfamBp8_mYe@krikkit>
 <0a03d16e-d4ce-422d-9492-3e31d910d8e5@app.fastmail.com>
 <akbdFcQP7oTp_n3s@krikkit>
Subject: Re: [PATCH net] net/tls: Consume empty data records in tls_sw_read_sock()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Thu, Jul 2, 2026, at 5:50 PM, Sabrina Dubroca wrote:
> 2026-07-02, 15:52:49 -0400, Chuck Lever wrote:
>> On Thu, Jul 2, 2026, at 2:05 PM, Sabrina Dubroca wrote:

>> > Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
>> >
>> > I think tls_sw_splice_read() suffers from a similar issue (returning 0
>> > even though more data may be available). Sashiko agrees, and also
>> > found a few more pre-existing issues.
>> 
>> Do you want a v2 series with those issues addressed?
>
> I'd be ok with this patch going in on its own, and the other issues
> being addressed separately. If you have time to look into those,
> that'd be great.

While I'm waiting for this patch to matriculate from net
into net-next (as it is a pre-requisite for supporting
TLS Alerts for in-kernel TLS consumers), I've started
looking at the Sashiko findings. I might drop finding #3
because it doesn't seem to be easily reachable in the
current code base. The other two seem straightforward.

-- 
Chuck Lever
