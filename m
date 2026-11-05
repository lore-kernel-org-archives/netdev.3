Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914993;
	b=ObVL4yXASxJLGXiwCh0+b4CsZRMk0d6OHrq5LYb9PYRnqjeuo4TyfDrVkxU1Hevx1V9T
	 yHCPg86xanWDNZdV9jPHLsWX3/YE2hosqrmT2F59dyLQQ1gOI6qYCUdDSkHkHnyTh1bqy
	 6XbXEOtlTwAkCRRwTwvfaH1YtdPX2u7Z29HgmSzmXe8S11pR8E6cq2r6GOwFpiiZyq7ED
	 Gfl+YoNMa3IGV8ehYnJnwOD04haGjnh8lWzgQB/olObp9qclWDOqG+IxNfgeXh1purT2l
	 o5ToiHXbUGHNvZBV+vuyMhfxapUT8tosyhR86RHoWO9dlD9zSgUlH1DmR591rhU9q5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914993;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=7PpH8CFYlHnNxARQXs8IGL2UM+NxdPruNFdu22N3C0U=;
	b=hBBGSytpEuDEEgRQlhyK5PeBhzPR3QFSWS6JxgyUy72lkco2gx/0kknkf4WOhPWyqVHI
	 XcVyW8+21zg9uBbgc1jV6mq7qyGm+f6PrSByqJSkv/hkVBhLIpUmPI6PnBaumgLj6EZhE
	 cgwNcp41HtjD7r+PrypPEUxqVIXyXb/BIWzpDU/osAr2XpWNgKiPqbTIa66iVizVLmJSU
	 /9fRlzqlYinPjnynuTC4rr0FOxRR87SotElfXEkTfb6EbqH+/hLQpU1Q0MCEuiQflfEzW
	 uk4eqdCRqekr3BhzZ3CjwdMzdSljdyQBxVx63X1pqF/JIDfoDu+lT/0EoZG4Hz8n1/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=t8T9AI1V;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=AEi9x9En;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001A8606A328
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 21:43:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 001A8606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=t8T9AI1V;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=AEi9x9En
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5LY6Lj4118728
	for <netdev@vger.kernel.org>; Thu, 5 Nov 2026 16:43:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=7PpH
	8CFYlHnNxARQXs8IGL2UM+NxdPruNFdu22N3C0U=; b=t8T9AI1Vd7hp7houkyi/
	GYfcLUwnU4sZfiJvctTAZwu9l062POejIyMNEIQrj3kPhrWVQjnju5GxNZddOoGn
	7D5Q4ugEm0U3FeZ7TugSQ6rCqBRjC5P29vRfG+D0YXd0g4976jbCcFG9yjQG1QZp
	WAb9M2Su4wz1BsfncLD0mgPp+tqD0KFrEY1tUZblbveKwfTwNsIqTtypVhzeLANn
	54tiWbS69pUJsbX/FF6aU3dQfQNON1UZ8kwIPGB/wnWuCFYzYBvlsE8qjDvibXwK
	inTDKwdZ4OtVcxUITJd1QJc5iX2cpaD6hJ5qaR6goC5nxDFL8hOcTWePGWrajTPj
	8A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hruw2v74s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 16:43:11 -0500 (EST)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-944101e6367so1917685a.1
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 13:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793914991; x=1794519791; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7PpH8CFYlHnNxARQXs8IGL2UM+NxdPruNFdu22N3C0U=;
        b=AEi9x9EnboVaht8lN4QQTZWLR125/O9AbZnH4Cq1qfR4aYdOVCSJJvtU/YiicWGrYz
         iJh6bJH2RZzyAJrO1+bnCPtb5hd6yH3Or9goq4GIwMoMmK0JOatA7M/KX1pW/77fc7px
         HpFPxHpOj3A6WSwOoBzc1IrZLlEg2y86xZJvc3rlfz+xJ7ftJhVYU5xTlbEhEoRhrkp5
         B44sR/IaBQqxm0FiPnNEwVijQ1f7Xy0FlVYmZV+K3vAI5v48XOeX+2WLHRXN5K+mqbNC
         d88CxIwZ0uyTuIZUlw/c66JCT3Rgnej5kTfKHfMNMo+MdtRfKkgSpe63C9B35oCYJPKp
         yHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793914991; x=1794519791;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7PpH8CFYlHnNxARQXs8IGL2UM+NxdPruNFdu22N3C0U=;
        b=Sft9YAaZPlunb27KTlpzXSU6NBrweMDyfS/FE3bCfQscXPA3/UpT0AGu9huGIhOToc
         z2Mq6Pq8SWoqQ5vYImm63u92CeFvrsaHDIVz0njQxJDSS5cyrSPXp/2HGfz4ermmvuKp
         7X+kQhYvMoHvKOJnoFZcAeqYYaHGoOPkbwKF5bHOVfnlEwXWcKhC2E8zIeemzEUENOgv
         IW+rd3OFVKrAeVcF1FGAbOSKJIFrht025mgfUXFPVHXi6N7uCHvB2uc9XfGy6BScw+Eu
         PFPKiVY2xVDFc3y8hsx9Y43rFj7UCFiZA7+MZejEc/kUpx4z+9zadcxjRj7bCsf01fOS
         uRCQ==
X-Forwarded-Encrypted: i=1; AKwUvBxdSN23dvyz0s/eWUzjqyqhlDXGkVKz/79aupMFSIK+wlWnkbd7If/Zyq0gUYMYNjkXrQ1cB54=@vger.kernel.org
X-Gm-Message-State: APuU4Z/dWf1toFxicoR24NiFGzWePvpTrNNPVS6k4Q+SNsRyZNQ1BYPp
	Qie4GcDsEIRxMlqTQWDuaI3S0rwZyxQkwp0SbTVuC9imZBIpuD05AOuofX1/5HJ9AAg79i8M/oa
	rdqOmHrBmiqfaugeGOABCGYzNTuiQnBIAaQsfnAGUqw5doFBw9pdP7w==
X-Gm-Gg: AYBFou2N08MqDZ3qHcL9g0006hdLxixqfiFZ43TXw0mpjFHGuX6BGJj+Gb9fQQaQrv7
	yKsk9ZG458GQlZVNE47jrbC994Iz6xjMIaB28kVIYPwqUx675dCtssQ2z9PiIu7TqTHpQTOvUi4
	1tghTT86yI7ihunWh9QFOqdlgm05CggbhPPqrQk9BwdmPOjc5oTXrq5DqtYyfD1COiEAxkCm4hm
	mFPQ+LzQQ0/UEha77brq2sqyelXreVqfyEvjdt2iiVOzyJracvEhZ0Be7mis2UxAETZya4L++Cq
	iW2YwW9ss/Xcd/AbqxdUBRnTPM/MQeZSMA9Jbg/9r7Wd4KZCrZAeNZK4MYQZ3XF7v6psuCvDffx
	IVHS5AddKxbF4gSkypoQaMM/oUOS9XgncQWL/3wSUNhte3MsNLLicACBSLOlhOvNsXb5ppe1pw9
	p8e/xEB2KVkH8OYrpiUW9W+scNygvncofHVVrEQ1xxac9CNRemrsRJ9bGw3+fWMpDErthmkvNpe
	HCwxzF5VXizuy1El98zaWxkMUjlusgs1OtZkLgIeGnFVfE9WsvlPrUc5gZgdK+m
X-Received: by 2002:a05:620a:600f:b0:945:e177:895b with SMTP id af79cd13be357-945f346873dmr64369085a.7.1793914991152;
        Thu, 05 Nov 2026 13:43:11 -0800 (PST)
X-Received: by 2002:a05:620a:600f:b0:945:e177:895b with SMTP id af79cd13be357-945f346873dmr64366885a.7.1793914990883;
        Thu, 05 Nov 2026 13:43:10 -0800 (PST)
Received: from [10.206.221.57] ([129.236.229.247])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d488e442sm546673885a.40.2026.11.05.13.43.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 13:43:10 -0800 (PST)
Message-ID: <06ca7638-85a6-4fb6-9cac-b495d213ac05@columbia.edu>
Date: Thu, 5 Nov 2026 16:43:09 -0500
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: cancel napi->timer after the grace period in
 netif_napi_del()
To: Martin Karsten <mkarsten@uwaterloo.ca>, Eric Dumazet <edumazet@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>, Joe Damato <joe@dama.to>,
        Dragos Tatulea <dtatulea@nvidia.com>,
        Kuniyuki Iwashima <kuniyu@google.com>,
        Stanislav Fomichev <sdf.kernel@gmail.com>,
        Sridhar Samudrala <sridhar.samudrala@intel.com>,
        Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
        Wang Zhan <wang.zhan@smartx.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, tz2294@columbia.edu
References: <20261103-napi-timer-cancel-v1-1-55c631ad5286@columbia.edu>
 <CAL4WiioJuY1L5ji7tVXggp=FDm3eidwekpxqAMdnxWUyiTR3fg@mail.gmail.com>
 <ae3e5838-6985-48be-bd99-fa5a21143942@uwaterloo.ca>
Content-Language: en-US
From: Mani Tofigh <mt4022@columbia.edu>
In-Reply-To: <ae3e5838-6985-48be-bd99-fa5a21143942@uwaterloo.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA4NSBTYWx0ZWRfX0FBupJZnee9n
 6cp2o9ojzbt9iU+7UhoaPf4nNnYXA8NkvlceqbnlfxZArNrHU+dGQ7rcJMsFfeRIfy/E3B3wIfL
 xcVYm90SJyI0x0UnI9t07jfkCnO54aNxuqlKFsCQ5/JkZjAnGVyL
X-Authority-Analysis: v=2.4 cv=SJnXx+vH c=1 sm=1 tr=0 ts=6aecf86f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=JerxfvFqMz+qeRdZ4jtV1Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=Xv8004Xbw9qiBDHpymQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: c9z0d8qPAq-iLhxrrNRXYpbyfGyLUYD6
X-Proofpoint-ORIG-GUID: c9z0d8qPAq-iLhxrrNRXYpbyfGyLUYD6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA4NSBTYWx0ZWRfXw76tSPM/FuUK
 m49hqszHmdDylPhLr/cSBBtabMoxTlco4AwzqvWqn+BwjwbJgPhg7BaCWQ0Ge1Ruuugk0Syi2rA
 9I1ZdQO0vPI7aWGmmYZmyd3pQl3Zodcxanb5bxJJz7YFevVwH7QOgVpa6NbfQWPBSawTkhp7AM0
 sO09UM8+X+B6nWq87M0KVBS7k1XM3mOeKyLWjq6wI/R16oOzEq6TFXdOKdk1T/0k7yY22oP01si
 Q1iGzU7fv3hZKg0YGsqr8drW4JoiAOEW1JMvXGIPqx49x/Zc8QBDPJY9u1qK0uQqR9BcWk03MAy
 dqhZPfnrjBmwwSC0IOKqGDDOuwZoNSfhgysHDQ27sy/r0wsqx+OgESy+DskU7YiYCMqNjAZKWmS
 M7pHLp3kb/gnlvIFyfu66b8ATtUznMkPvSnwLlezwkdtKYaHKA+9dk1oYMD9GDa/807Nka72fpA
 MVO5UIAmdXa+Wcj8c+Q==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11957
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 spamscore=0
 impostorscore=10 phishscore=0 adultscore=0 bulkscore=10 lowpriorityscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050085

On 11/3/26 7:55 PM, Martin Karsten wrote:
>      if (unlikely(napi_is_scheduled(n)))
>        hrtimer_cancel(&n->timer);


This worked here too, but I think the cancel could hit a timer that a
new owner just armed (e.g., a busy poller that clears SCHED and arms
its own timer right before our check). I'll go with Eric's version.

Thanks!
Mani

