Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792662891;
	b=FgnaKWQTsrpYqby1AfphQ0uZqMQbLmEIefrzQVaJkKMvNgL3yc98vqoKSJjym3yvtoIk
	 am9ddlACpyPzKUdVvZuEilligd2XAhJWmIFHuFf8XEqsKl25OtgN4uHrPaOf0MLSqoF3z
	 BeapE1semG1MC21k75hlxFf6WL7Qk9vLJ8AmGJuR7vANfA83b5fttIkIJ8ShRbYYX7Ilk
	 jg8dAfw2/CZrBFChefusYe/f57EO96Jru/E93YyNRyghJNYI0gr8Lt9IbTJMYGApS/ErV
	 Y0vNxLa5dhe1n9IOnC1mRfKCM7v40bkTSsIF241hOnNNaomMOV9xq5eLH+u0ci9/5eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792662891;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=r9kdUhEEdo8G0E6TvnmRFTKj2ShBGFBBRPt8LMZ5cqk=;
	b=bIHDu8rwp6mUmHNWkDgTJadJNxneIVGmHDuLj/wmri1Xiir1CelRh9w/Xquyq09BULIk
	 BpIJPYxTxuj27tiHYwjilNX7+sIhstbIW6ReZpUm4KCnM+bHe/ik9PQSflesZUb6Xu8JG
	 kt7VObR7fvcWi2KAD8yzoA0iwiUmDMt6NaiDeirA9PGGvIlgvUpcoSjWfr1gVpaoUabsm
	 mounhoxz0sUW8I5StRbXV0Wu2eUytAWuEmjIbZoFXignHs/wCtcI2ni2MHYxMhByUK9RV
	 nJIvcXlwrK5TvI9U3bCbOQgShupEgjL4NIkIHCuz/AbWhhXqZbeUHGUaRXKvG6uiHgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z+x7UeBK;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A054606A31D
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A054606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z+x7UeBK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792662890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r9kdUhEEdo8G0E6TvnmRFTKj2ShBGFBBRPt8LMZ5cqk=;
	b=Z+x7UeBKS04VLIz3yczMpPy1476lSi9UaJyrl/LASxmVVP3AWr876GwhSopwoRGZiYP9He
	Z1zqg21rhu9jHX+iMkQm3W0a8uU5xxxdJBMv553xhhOrTWCER/R/g38LrQ3tnzn4gXZ9aB
	K8k37yXtVcIOYroRQRS3vBkrDIU/I6k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-u1OIUuDQNcCF9nGh51KurA-1; Thu,
 22 Oct 2026 09:54:44 +0000
X-MC-Unique: u1OIUuDQNcCF9nGh51KurA-1
X-Mimecast-MFC-AGG-ID: u1OIUuDQNcCF9nGh51KurA_1792662882
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4920C1800633;
	Thu, 22 Oct 2026 09:54:42 +0000 (UTC)
Received: from griffin (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7ECB8195608C;
	Thu, 22 Oct 2026 09:54:37 +0000 (UTC)
Date: Thu, 22 Oct 2026 11:54:35 +0200
From: Jiri Benc <jbenc@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Aaron Conole <aconole@redhat.com>, Eelco
 Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Yi Yang <yi.y.yang@intel.com>, Pravin Shelar
 <pshelar@ovn.org>, Jiri Pirko <jiri@resnulli.us>, Victor Nogueira
 <victor@mojatatu.com>, dev@openvswitch.org, stable@vger.kernel.org
Subject: Re: [PATCH net 5/5] net: openvswitch: ensure a linear inner
 Ethernet header on NSH pop
Message-ID: <20261022115128.6eb99768@griffin>
In-Reply-To: <ACT-N6N4.v1.r0.20261022051412-5@mojatatu.com>
References: <ACT-N6N4.v1.r0.20261022051412@mojatatu.com>
	<ACT-N6N4.v1.r0.20261022051412-1@mojatatu.com>
	<ACT-N6N4.v1.r0.20261022051412-2@mojatatu.com>
	<ACT-N6N4.v1.r0.20261022051412-3@mojatatu.com>
	<ACT-N6N4.v1.r0.20261022051412-4@mojatatu.com>
	<ACT-N6N4.v1.r0.20261022051412-5@mojatatu.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, 22 Oct 2026 05:22:22 -0400, Jamal Hadi Salim wrote:
> The fix:
> Pull the inner Ethernet header into the linear area before restoring
> MAC_PROTO_ETHERNET.  This is the NSH counterpart of the MPLS/TEB
> producer fix in the previous patch.
> 
> Fixes: b2d0f5d5dc53 ("openvswitch: enable NSH support")
> Link: https://lore.kernel.org/netdev/e85fa16e-df3c-43dd-bb3a-9edca07200ea@kernel.org/
> Cc: stable@vger.kernel.org
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Reviewed-by: Jiri Benc <jbenc@redhat.com>

