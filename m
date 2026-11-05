Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=199.67.87.4
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793903561;
	b=HKCrboydrR4oZXojxEre46tk2TetbTbiMX5eeyKGhl8YR0x5Hgoqkj1m6waghuQNvlli
	 tBJcvmMfZok7JxsxjKs31BE037GTiMnHmR64+zkuA68bh4iYFGfVYVLfojLS+RJGDzQqb
	 /Ypk5gQvju/CU2uvklaLnS2NpFxt9Af0VTSpl/lwzNedDk/tivlmnA/IFjGrDe1qwiIw3
	 WKK+XB3wXnN+qD/wN3Xv7sBEAqFIPZqdDYI00yQCuzjY21/3DpP0quzuV7sW3aWyFzb3s
	 lf9/aFNLDRck7jeS0ud4tXEiE6VJWsBIdhxxs43AEo4Fcgo4Bipk0hu7UBPS+omxPiw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793903561;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-ZohoMailClient;
	bh=SvsuAkwZHWbcOqwW9xUcOdb7Lm/qlh2uIlji74Ktz+o=;
	b=YjOWP153zvt2gsBAziR/RpxmB9bcjNGU8Gy9CnTnJpB4OaePDi2uOwQmaa2A0WcZHxPi
	 7yeSixUeu6aNxeRZ+ehdxgL8BPXvL7gYlRCcmkWULiczRbcxifVwTwFl76/L3H3+8cjN2
	 HsqYths6T1vp0306gjolUDroNO/BgnIqdhjVUxw40Cs/F1MxmEzfVOeuNbkMaob2xW8YG
	 4dR7CZo/QNbpgk9SfSpqcs9Qjg1NxIpWeBQLyoHkQguv2T7F74hlVAVdEOV76DamQNwQf
	 PFmTA/4xgyzP0LIBjslCn5uI6rSbtCZZho2rSB1623a5Vdb6tt5J+CEdvNiZ9WzlHNA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=chasehil.tz;
	spf=pass smtp.mailfrom=chasehil.tz;
	dkim=pass header.d=chasehil.tz header.i=@chasehil.tz header.a=rsa-sha256 header.s=zmail header.b=aARXlpdJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=199.67.87.4
Received: from sender-op-o4.zohocloud.ca (sender-op-o4.zohocloud.ca [199.67.87.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D29606A326;
	Thu,  5 Nov 2026 18:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8D29606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chasehil.tz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chasehil.tz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chasehil.tz header.i=@chasehil.tz header.a=rsa-sha256 header.s=zmail header.b=aARXlpdJ
ARC-Seal: i=1; a=rsa-sha256; t=1793903538; cv=none; 
	d=zohomailcloud.ca; s=zohoarc; 
	b=c91X/5eDEGF9P0Ycsq8qFkhxRWCQ59eJOXrX2+9KaM3NyokCLs6k+lR1HiYoa/ZeSw3xeb+d0vZTKmWt92cObWj54NLlFMOBcktCU9eHwmSmW/ZWX0ra8OdFaEvFVmCm3Al706HHfqltz7CesaXui5k8StqzRInFEZifaBGdR7A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomailcloud.ca; s=zohoarc; 
	t=1793903538; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=SvsuAkwZHWbcOqwW9xUcOdb7Lm/qlh2uIlji74Ktz+o=; 
	b=DASfqo6QCwUpExF8tBW1XKDtjI5Epn0QdoALt2BfPQVtmiUTtwWdsMA9PC9RlTsYVlXX9NfA851kW2/3jip6iIMEO/8gJdyBG+myEhYaXpKCDy/w9KweZ0RMd7tM8aAloN93sskeLoV9BBFRMth3DByl5BtxYrgotINSp76qAUo=
ARC-Authentication-Results: i=1; mx.zohomailcloud.ca;
	dkim=pass  header.i=chasehil.tz;
	spf=pass  smtp.mailfrom=me@chasehil.tz;
	dmarc=pass header.from=<me@chasehil.tz>
DKIM-Signature: a=rsa-sha256; b=aARXlpdJL0OEmKwk9TxBVNidOJUENfDyYJf8eIymybtFHIhkRCKKH4aBWadQ5CTJyn4m2oZrVek4YeLDdTtb+uVXuGJOh9S/N4Y8TlsrKELPjksj3UvPIlHgtGjhyVb/k7fI/3aOUX2o4InwE324x+LpvJyhRqr50y5nHX9zZmo=; c=relaxed/relaxed; s=zmail; d=chasehil.tz; v=1; bh=SvsuAkwZHWbcOqwW9xUcOdb7Lm/qlh2uIlji74Ktz+o=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohocloud.ca with SMTPS id 1793903537413376.01605994709155;
	Thu, 5 Nov 2026 13:32:17 -0500 (EST)
From: Chase Hiltz <me@chasehil.tz>
To: edumazet@kernel.org
Cc: netdev@vger.kernel.org,
	dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	weiwan@google.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ipv4: route: don't blackhole in-use routes when retiring fnhe routes
Date: Thu,  5 Nov 2026 14:32:16 -0400
Message-ID: <20261105183216.3002082-1-me@chasehil.tz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <CAL4Wiir-KjBF-rdqH3_KcjbBruVAC2JN_B_S4dYHph=bpZkbKg@mail.gmail.com>
References: <CAL4Wiir-KjBF-rdqH3_KcjbBruVAC2JN_B_S4dYHph=bpZkbKg@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On Wed, Nov 04, 2026 at 07:54:23PM +0100, Eric Dumazet wrote:
> Co-authored-by: is not a tag we use (checkpatch complains about it),
> please use Assisted-by: instead.
>
> The changelog is also quite long, you could move some of the testing
> details below the --- line.

Thanks for the review, Eric. I've addressed your comments in v2.

> Note that IPv6 has a similar issue in rt6_remove_exception().

I haven't looked at the IPv6 side, but I'd be happy to check it out
and submit a separate patch for it if nobody beats me to it.
