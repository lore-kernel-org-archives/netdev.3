Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD278223DEA
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 00:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786062051; cv=none; b=oKo+J2joWDPIeFlYEJRzJFZUWykEru76rbfutSdfXA2EQ73kgxK8ZyN/zepTaqwRfAqKoHKl/Vf9+HRiPPObA6iL43GDP0HrP4EdzM06HT21RTV003zDj/7TGdWyX015jmM/8ap9WyqT3Pom+W+g12igpmW9Sn4EeWd+lzBT/+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786062051; c=relaxed/simple;
	bh=p3LsJQjqd++4Om2G0h2XXjMJa1xYuFDhErPRV0y8Gyk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=PLNB0JkH2HGLaRN6s3g8blpioM5u7GoOhf4V7SosqmBEQ3dl/Jd3M1uyDTuj5tUm3mATjlJ4e6h7DDwXDCmsDmFgirGL2DeuPUsgwmxn6IqLGv1BN4lPl4yKVFgYeayay9bmdwIa8XHobG1SL4/f8mt1fIf8wcF9F1kCHXGNamk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpwqkY92; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpwqkY92"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2981F00A3A;
	Fri,  7 Aug 2026 00:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786062049;
	bh=SiSwk3Up80zpe+rX7ykzgEhuiD1iYv+Js5A4E28WLwQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=cpwqkY92cYaJzDiDlm30Ab1U+Yi3pI6LUJ8Q1dTII4lGxCUINXkYKxP+++8kv0PvU
	 2YZ+BSGMIYDFrMQSlxc3hdrzwL41Oh0rrpsMPd28tIkYlFYl0P/rLzJBOYR8JteJFY
	 f5td3fkUw/gtdQ4W00ztnJLYQJB+a4Im+efU5fA9UXgfFC5SjzHBYGofpggiTKY3E3
	 a5QT8dxDsGuRMKwpuYqBhjHOiqCExGeibr/QTfrmDDzvwiVmQlllhcN/s9Yzn9UWCY
	 ORLm3ajc5QMdadiBvISOYwxg1932HXsc6+RHX4O1ICx3R+G6lGTsihdXVrBVZS24EK
	 2+Tyw/Rv1FGhw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id E149EF4006E;
	Thu,  6 Aug 2026 20:20:47 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 06 Aug 2026 20:20:47 -0400
X-ME-Sender: <xms:3yR1aoRqlK5sh8mR73H7f_RNNriQSMQy4gpYSMRIh-tA8aVSlBAJ7Q>
    <xme:3yR1agnGIjLjPcamg1j110L0CJWLBOzt4RmMi8DmtKW93l4M84ez8JPfZGf3p6Y_M
    RHSB5jPzm3Djyk-06Ux3xPetI2ZEqiQUKAZfICjcCIfV7HNwTW-9H6R>
X-ME-Proxy-Cause: dmFkZTG4ELMJdm2RYTJe5KSfzuNF1duodZdTjSH92g+jCJ1jZp1GfxCxhytzAYW4dHPwnq
    sWSAdUmInHf315e61gJAv25qhwb29wSZPtdj9lg9cM4Z3lRAArl3wBR9RmhjdZNyxKZwyE
    s0g+4TwkAA0/jkwZ8fZnXzoS5jhg+tlVZd+hUPGqnM9B9jwX2uBcKycWPNVcAC3qNtenj5
    ouxOdTfCMLGYtScvCZ+dPBREMGip42Gtxi74wIVR6bS6dEtIfyQRBByI7k1gz0zNIUAYjY
    ovD4ISWAleUALuAHVhEJx1CAKx78lOLyYn/BHxV27gr0+TZ2Bw8XjhRQdY+7cl0Y8+louB
    L+WKkZ1705m455uVWtOJiwJX2MdAB0s6mZl/jmesOB180fMvRvKqWxVmCxTSFL8bV3J4Nm
    oxriy2zaAr+idFNzNhnmWyq0cQNvm5Rxnhz1Tquh5FUZQbwDH/BiujvdwCyrJlWP8b5FvY
    I/lpevQrk+RWAAN1TiJpUma7fYskSpSqFjhVLDAcXhjy/ZukVnu3IL7xbpviMgk8TSBdwA
    wSdzaiXQE+FmGBrRehP09AfG3EQOJJ6mXlHkfynhccun7oxeo7lW2TbNu1RD8v6Zc9xE72
    Uw53NAHccLN2vhXdbOgzqsM6OeEXX3u9e/fncToqWYPzgEJlINUxYCH+kqbQ
X-ME-Proxy: <xmx:3yR1at0XfAEXwWyBJ8J1E84FPzZMBke0mVVY7sL5Th5vGyNcr5V2iQ>
    <xmx:3yR1av-J57t8Ib--gt5biR2nCbrMnskez70u1ZDr7_QQK8UvrlDoFg>
    <xmx:3yR1aq72bzB62CFA7XnKAsxSnw5JWnpVBMYehIhIIrXX2mb6Bs2Oxw>
    <xmx:3yR1avvG5UBjF8fMP9_nM-hEz-n_RquX5TjLbD6Cl0Myu8wFFTxQaQ>
    <xmx:3yR1ak10UPToe6QlbXxDpkeClerTOt0dNO8sGPM14XLH7qv7bdDbgD_E>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C6F17780070; Thu,  6 Aug 2026 20:20:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AaCQ_tCgbt_c
Date: Thu, 06 Aug 2026 20:20:27 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: "John Fastabend" <john.fastabend@gmail.com>,
 "Sabrina Dubroca" <sd@queasysnail.net>,
 "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>, "Dave Watson" <davejwatson@fb.com>,
 "Shuah Khan" <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Message-Id: <885eed00-f944-49ee-ab97-ce8853091124@app.fastmail.com>
In-Reply-To: <20260803154707.6dc9171f@kernel.org>
References: <20260726-tls-follow-on-v1-0-99bf4cc1c729@kernel.org>
 <20260726-tls-follow-on-v1-5-99bf4cc1c729@kernel.org>
 <20260803154707.6dc9171f@kernel.org>
Subject: Re: [PATCH net 5/9] net/tls: Consume empty data records in tls_sw_recvmsg()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Mon, Aug 3, 2026, at 6:47 PM, Jakub Kicinski wrote:
> On Sun, 26 Jul 2026 20:33:33 -0400 Chuck Lever wrote:
>> -		/* Do not use async mode if record is non-data */
>> +		/* Do not use async mode if record is non-data, or if it
>> +		 * is empty: the receive loop frees an empty record's skb,
>> +		 * so its decryption must have completed.
>> +		 */
>>  		if (tlm->control == TLS_RECORD_TYPE_DATA)
>> -			darg.async = ctx->async_capable;
>> +			darg.async = ctx->async_capable && to_decrypt;
>
> I vaguely recall that we depend on all records being async
> uniformly within a single recvmsg call

That holds, but it keys off the accumulated async flag rather than
darg.async, so a synchronous record among async ones is still queued
on rx_list. Empty records return before that block and copy nothing.


-- 
Chuck Lever
