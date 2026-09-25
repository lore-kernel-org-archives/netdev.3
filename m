Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49785286425;
	Fri, 25 Sep 2026 14:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790345914; cv=pass; b=bTvzmZs6IeXXD6kKyJNcEbvKrOgYtxymUmCPqhGrvocxIjwTIYgLa6dD6kQAcwwnKr0Uf+/73813arxsO/Qph3iLdkl+OxvaulNpys4zUbYLgujAlHJn1qPHvBtw/P2m9CMkslZHEtSzrxrTrIxr8FZ785bdbss9avkwkMHMtoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790345914; c=relaxed/simple;
	bh=02HI3Gd0i3pyIFXxptZviDeo1MkzmKnEOfZytROwY3c=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Eu7BvA6qX9UC4xqUTRGNoYldAe/5vL51vzcFH2FHmB0EVMGVscHn/p2srYJ1xjwgVgzZMgO33qwxx/yLrkFjHI9SFE05GukMrMWlyMQcbeeGBzMLVK7kRMIVmCMY3YSClJaJMBB/zKQogjQfrjDz8wHME8t/znT7AVDR1gRez2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=sRdtWOvU; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="sRdtWOvU"
Received: from fauth-c2-smtp.messagingengine.com (fauth-c2-smtp.messagingengine.com [204.75.18.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmtilli)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4hrt8q4hhlz49Q6S;
	Fri, 25 Sep 2026 17:18:19 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1790345900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=02HI3Gd0i3pyIFXxptZviDeo1MkzmKnEOfZytROwY3c=;
	b=sRdtWOvUdps8iNdTexk9Jq2K+C0REedvP1lZJg5vemDnmQMQQ3sm4ygSpOH4s/4m/dE8dw
	mWW/rSfgcrYSB63XOhcFBNKJtCMLixVAjgdfd3q+6n1MuOVT6TBZvdZ4R9U38KVP0pBlin
	clKbKLFHqptt1mAYpCM2CjvZOGC0HuIVv3VnFLYsmoQmy/yvBKLQjvNhMZnCwjNXb5QxnV
	uvf7+2G68dUEyDKd1T9vU6BWvInCfNuaE9dm0ZE0lf8nZh3z5+rNA8hV5v/YU8H+SSJ7t9
	+vCAsiqrQZSkXNEpQy82IsRnkd1N7V6SSjNUpB91PMd0axEo/Kpc0OM6kvCs7w==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1790345900;
	b=jVeOJFmb/3rpM83tVsbhPKYkuRQSq2oeSbq6uvMddooKslwF93tZMdi2KnwfNvjkU9PrCb
	e0OGMFFrT95HSMbkxhavLmrbjVGkManfWULXHPn0DXcN96eoCXfWnP82rCawi+Kmq4bmW2
	qOT20GbKrWo8FbBd9svpRfmd70H/KWjcHpHcB8X3CGvK5m6xo6PKKjZgHOyPoDTcrusdpb
	aDeAqanLcIsjLJty8Jy/irzseaF+71LgtIGCkZPu2sjWRmqycVjdtv8J6wMIY8BkExJr9F
	idFU+bwRpLYIG4hvGBXCaJf75lLQ1edYPQBsRwW7gOSoaliNHyQCbYTfqlDGBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1790345900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=02HI3Gd0i3pyIFXxptZviDeo1MkzmKnEOfZytROwY3c=;
	b=aZuHH02QzGz95k9jrNduKk1wHj7E6hkA9BNQ8gCg9ceWmOh6IJAHXAt5dAm3QhAELnx1BX
	rqrLAw2IOfa7/ok3Ho880NYFwitTy/HuG1Xhcdd59ihFmxUWkdwi6GRCBqF4XW2ViDT4p3
	+v6HW02jqFxukf8/KNQXbw672wfO1WScE5GmM5kXKdpbJ+0cv9G3euJyP9cycFWL6aEW7P
	r86Wec6UeqlCEJI6AitDasCiSEfsl/QJvykVdgJ6DtprUWChMxj9BIljJ/fbilyXK0JBmq
	xyHxgmAfR77QAD6Vav5W3iKwhxx+eIi6D0KHUs3s7a44tFOs7i7eLYzVWN6fyw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=jmtilli smtp.mailfrom=juha-matti.tilli@iki.fi
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id 0B9E1198005A;
	Fri, 25 Sep 2026 10:18:19 -0400 (EDT)
Received: from ams-imap-13 ([10.64.2.33])
  by ams-compute-02.internal (MEProxy); Fri, 25 Sep 2026 10:18:19 -0400
X-ME-Sender: <xms:qIK2atgsua0tF96b7QKWNDl9lm7R_Dj7V_ETpo4FAqORrOc57AzxRg>
    <xme:qIK2as370NguGk9nUpegTcz18X2SO6MWU2knFNLzN7kPm5J5KoSYeRucqkywoSNBs
    cJI6Q_9CKyS5OstgAm8j1XD4X8CmnsOVWEcfhTKR4RhclKGmKunrKXs>
X-ME-Proxy-Cause: dmFkZTFig1SXBo3qZsT1AZhF0+n52ZbYWBdqUb+cbB4VEsPctKu3tj+7Ur8gdha0wgkn4x
    M9PqPAayUqKdrwtN+dKK1879+21cfPasXzF0Ni63A6H4jBPvNXdtUHmDdpjruPG31ws0hQ
    Hik8MYam2jqZb8aox6HCQiqPGisSlnljKyKxu++353GiJDjXq01BAjV3KlWbjExViWIGc/
    aW0tkxYFy1B+ZEOFLBrkkuj2c17Q9sQc/rd3fbopjvYKJ8zK+CX1prIYaSmCd2FsxEgUDl
    2p+2CvxszkDlj5FAxktGXwPnM/wzghJvhVWYfkrdqZ1kzL468jlVtTCi8uG5i1VvKDsYog
    ybUuRfwKvEsDxXFeMykkj3h4d9jCsZ4f1U9UbOaFrUINOaPVih4rpgClDxv9dKkVBy2i/8
    Bqx+B7dsg/bZHxmvEN9ZAkqNONoiWIRT55pfT6e2Ty6FGhjuJRK7Pi6H5S0GEhVLa+22Mf
    eRiHeFh6D7RkxFmnY2+xqaFYP0e+q1bnZD5r8QotSS+GeyqsjTWkFbPQOYuFtcFekRiuzP
    PKzwSjFWbWOwf9A/hjNzaE4ra7Q0ZfawgGeT6qQ9GuJAut6e5ZCFLtiWUog4gzloxIpWCW
    tZn+DZ4hXHMVIqJuBxL92WohpyTzMD29Rehe9RV5AG9mh0qtYCYZx91wV7mg
X-ME-Proxy: <xmx:q4K2auwxnF_GAS3YAlP-aASgfZVe4Rabe_3BadIK83TBdz59T6k1Fg>
    <xmx:q4K2akzxpmLBYZJnEfZjt0jpk2Mq9Gx7ma5FXC1VQeEfMhQbmiLxcA>
    <xmx:q4K2atSiFJ6smI9KsCPKnity4jmkrwxYb8h7ML8Lvwg5Nf7Q1H1AkQ>
    <xmx:q4K2anOT8Odin0qVhGceWX1Q3_biDPyRnVYIPsAXnNl4-6nV5jILvQ>
    <xmx:q4K2aoRdqmJdiZxIx0-44KMJZm9Q61FrGNQKt_Marwgh2kXgOmXZuxmd>
Feedback-ID: i02414972:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 28752F8008F; Fri, 25 Sep 2026 10:18:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A_PuV4p-mAYk
Date: Fri, 25 Sep 2026 17:17:55 +0300
From: "Juha-Matti Tilli" <juha-matti.tilli@iki.fi>
To: "Youssef Samir" <youssef.abdulrahman@oss.qualcomm.com>,
 "Manivannan Sadhasivam" <mani@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
 "Jeff Johnson" <jjohnson@kernel.org>, linux-arm-msm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
 ath12k@lists.infradead.org, "Bjorn Andersson" <andersson@kernel.org>,
 "Chris Lew" <christopher.lew@oss.qualcomm.com>,
 "Deepak Kumar Singh" <deepak.singh@oss.qualcomm.com>,
 "Raj Kumar Bhagat" <raj.bhagat@oss.qualcomm.com>,
 "Jeff Hugo" <jeff.hugo@oss.qualcomm.com>
Message-Id: <73152e3c-fd11-492b-be04-7986f6af03f6@app.fastmail.com>
In-Reply-To: 
 <CANyhwx1EG=2FyBm150wrKpj=kQ1066iwZWndx=ZL3BKNoZUhVA@mail.gmail.com>
References: <20260921-qrtr-multi-ep-v2-0-27dd80d841a0@oss.qualcomm.com>
 <20260921-qrtr-multi-ep-v2-2-27dd80d841a0@oss.qualcomm.com>
 <a16d507e-17f7-4074-8817-4b8da3a71c3b@oss.qualcomm.com>
 <8ed398ba-2ebe-488a-a213-8ca7ecbe861d@app.fastmail.com>
 <CANyhwx0hZJC6xXaSC2g4GFgUOp5n_KN4tdXksW+s8Mk_+7xEAA@mail.gmail.com>
 <ayyrvpxnxonroz6kafehepplhltnzgopgt6pn5fnpdmft6rbxm@a5sps2dnso47>
 <CANyhwx1EG=2FyBm150wrKpj=kQ1066iwZWndx=ZL3BKNoZUhVA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] net: qrtr: Assign unique node id for MHI endpoints
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026, at 15:46, Youssef Samir wrote:
> On Thu, Sep 24, 2026 at 4:58=E2=80=AFPM Manivannan Sadhasivam <mani@ke=
rnel.org> wrote:
> > On Wed, Sep 23, 2026 at 04:03:38PM +0100, Youssef Samir wrote:
> > > The chance of collision is slim, but still not impossible.
> >
> > When you mean collision, do you mean node id collision due to bridge=
d nodes?
> > Because, even if the directly connected QAIC devices use 32bit node =
ids, the
> > collision won't affect the functionality.
>
> As in ep_nid of one device matching the nid of another device. In MHI,
> that shouldn't
> really matter since this patch moves away from using QRTR_EP_NID_AUTO =
in node
> assignment, but as you mentioned below, it could clash with TUN and SM=
D EPs that
> are already registered with their ep_nid.
> > Also, there is a collision with SMD and TUN endpoints, but that's ou=
t of scope
> > for this series.
>
> I have not worked on a system that simultaneously uses different types=
 of EPs;
> only MHI EPs. But if there is a real case of that, we can move to
> global ID assignment
> that includes SMD and TUN.

Global ID assigment sounds like a good way to solve these possible
collisions. My patchset had xarray based endpoint id allocation, maybe
that could be reused for nid allocation.

One challenge in MHI is that the two sides, ath11k/ath12k and qrtr_mhi,
need to agree on the endpoint id. If storing it inside MHI controller is
out of the question, then the only way really is to use MHI controller
index to derive it. Maybe something similar could be done for SMD. But
for TUN, this sounds harder. Can ath11k/ath12k use TUN at all?

BR, Juha-Matti
