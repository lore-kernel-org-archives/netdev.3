Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794442995;
	b=lo1+3oyOEh6LbjRlLhUhJ2R0TvD3/ai707jcXzUnEBXat/MHEQrRT3rJ5czM2TgGYrMQ
	 izLQMz0ZeVEkocnUqK3+NtbE9mUJAdwpWim2lts3mtlt3d1G3VcaIeNykNGGrG6zNI1ac
	 z8SFC5+Os5EzhubDRMFR3GnopLMCFNw7vIdv0g+z7W9UHz2C6fLXRgofM2TXtgIAQppsS
	 I3MW/FEIkkRHoS0++zNB8WeEC9x8mS0wy1AyDGHJ9YsZkmLkk1Qr6mq/6qsmwLFupirXK
	 vxeAHyxI+GhrW9PycbGD7OcPSYu8vi17zlKuIM9RyjNLg/UZ3OHILZukssSfssf2mJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794442995;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=rPReUu3t/ubDPUia6daCimelDjDS6mqfi/IOHqkQ2l4=;
	b=vM4/RiasOaCq9sftUnxZLqDEuBncmP64CKb7gk8E7a5E6huzp319D+U1UUNHGOzUoyWA
	 qFlK9qpLHBXvv/Agycciw9sOrenwcuLBZI4UIgw6+goAjMyzV8uSGzCwZhsK8f5V6uZPY
	 mLWAwhIWoZDPPD14mujHJarZcFuiLjYu9v5jA6cqshSHRcGsb+cgcgI2fwLzH4owMJLNl
	 Wym1pD4aSSP9wJeH7btbv9mHBfXn6W6VmJSnkYB4db6LtFqaXCq1R0WueXBNsNxU8g4th
	 /26vCGStzq47MW3fUj3fo75cdgML3ZgclKtTqYOd60K+dX64gfz+hvbcrqEGflQ+fxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J7xRkkoA;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5CE606A324
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 00:23:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F5CE606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J7xRkkoA
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3b10ca4e3f9so2099587a91.0
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 16:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794442994; x=1795047794; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rPReUu3t/ubDPUia6daCimelDjDS6mqfi/IOHqkQ2l4=;
        b=J7xRkkoAyhBAUqkINVdkgP4gkBHjYHKAIlMJnz9Sq+RTrBr3CADSRqNA+i41R/7b+W
         nQi+nkYfsSXlRNfQ9otKDvehTvNl+4Zqr+KqHoIvTP5mnNmRGszT1WGp4w5FtqjWoCh+
         Kf+RdWsXf+nw+0jhZhBHb2qlJ2tGmBMQm4jHC495Uh7hK/TPEnoGD55zqWX7Wx5ELPt6
         efvq5mjdlh/rUzaEWKssNc6D8Wrb0IiA4puwiuv8rMnZ3qldNXqHyeHacQyu9ZkX2/ad
         FuwgS/kVRVeGaOYhGEZXqc1CJnzOsMZmNp7i2bNxXRybDmsReWxKiNEbR9+UYvn7TkS0
         N/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794442994; x=1795047794;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rPReUu3t/ubDPUia6daCimelDjDS6mqfi/IOHqkQ2l4=;
        b=PQZL+sWuy3XGNPEoomxiIHEvIt/06dW1fVenNecWAQ9cHKuRLX6sZCozC2M6JQaLmq
         1Jd7GLnQ4EWydh+lqCapttZUScA8+ZVvgiyhOj6TtqFaLv9xla/3e7Sg0idl0mreF0SA
         aMb9J1tpY6EeETcNAupqusqrZFA2Pu6AUzffD3zpiIe69b0u6xAaBJh8xH9Z6AhtDzm/
         LhKnrct2tECpuZqDlnc3+WE5GQAgOWOUeQiGiMuQ26eiW+M/UKn35/gznAl5peMqLLDy
         H4A1hiSu1M72VF3Kd++ZvLctcIQ/BtrugctTPc2y05g7BsrQqWx73H1au36Xo39GhRRK
         BL8w==
X-Gm-Message-State: APuU4Z++4kYBFi8yziVxiy3oH7MqAcSa92v+5GsflCq7b62HJbhIyV9C
	X7sQS8RpgJuBi+zrBtqnH4Ts96Gz46ENMLAXgofbX6E/C03zAi4ALnFZ
X-Gm-Gg: AYBFou2mPBQj68Vgm8Ru0LFVY4o05ma2a/hPhff3MaUZsi/N3E7Hcgi82SkaV5NtENg
	VjKUehP/SNQo89D3EtanRvkbwgyAejbvMtCtZP3ji1inK82I2kN/sEhhz9AbqAdazzPfd6o5His
	jkDkb3KbTZ/CpiKL0hOjzm2/gBEGEk4moUz3k8AqmGRcqukX8MULdjo/VLWIYFsFH/K1YLkTljP
	/foecjt5oc0NIQGpQlRf/1elBRl56Rzze720w2iTFgwo6lGjh5Lm64aCOk9pQX5OVQ8b0fK2PRC
	ONHOV28FWL6fKnA0wniFj9GXaCXO2gYo6JTBAO/67Bc9maLk/FzZ3Dqm0LDEAx1yO5Z/iav4GWY
	akb0+pfomv2mwOHEcvYBCwHPJvfsRyEfsEa4OYfpMlMwhfguubB80JsP9nI1XUM/Al+evSxVbMc
	JDrjRKP1VkXK7A6+zKkgz9sQhJ3ek+pWDAZegtFCpdr0V7+Pn92sjzBl2HCAnC8kKpSFdXzHHm/
	taXvh/oZ7zqJPR/uV1GAXU2SaldMuAOAxdZG5d51lOwFi86SSJvhPsZAxR0GhaYR4HS1bSetIA9
	Q5eg//nI0nphB655DnvUv2DOADvObx/EJ54PiFdfejRlQGvwbg1idC1hZFdG8TtQL4jsF9qhq9/
	nzE74mG8yShHNvFgTMdD9UqZrHEFTwxdLVQ==
X-Received: by 2002:a17:90b:55c3:b0:3b0:ad42:dcb3 with SMTP id 98e67ed59e1d1-3b182eec120mr3269580a91.14.1794442994313;
        Wed, 11 Nov 2026 16:23:14 -0800 (PST)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b181b9419bsm3003238a91.0.2026.11.11.16.23.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 16:23:13 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Nov 2026 00:23:12 +0000
Message-Id: <DMSSYAEKE9XD.Q3C9CEHH7KTL@gmail.com>
Cc: <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
 <stfomichev@gmail.com>, <pabeni@redhat.com>, <tushar.vyavahare@intel.com>,
 <kerneljasonxing@gmail.com>, <bjorn@kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 net-next 0/4] selftests: move the AF_XDP test suite
 from bpf to net
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jakub Kicinski" <kuba@kernel.org>, "Maciej Fijalkowski"
 <maciej.fijalkowski@intel.com>, "Daniel Borkmann" <daniel@iogearbox.net>
In-Reply-To: <20261111155748.11b92b7b@kernel.org>
References: <20261109193048.1006986-1-maciej.fijalkowski@intel.com> <20261111155748.11b92b7b@kernel.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, Nov 11, 2026 at 03:57 PM Jakub Kicinski <kuba@kernel.org> wrote:
> BPF folks, I made a tag for both of us to merge / pull to avoid
> Makefile conflicts in selftests, the original series is here:
> https://lore.kernel.org/all/20261109193048.1006986-1-maciej.fijalkowski@intel.com/
> PR text follows. Please LMK if / how you'd like to proceed.

Take it into net-next.
We don't need to take them into bpf-nex atm.
There are no conflicts today and we don't plan to touch those files or nearby.
If selftests/bpf/Makefile conflicts it should be easy to resolve,
if not we'll pull later.

In case you want to add to merge commit:
Acked-by: Alexei Starovoitov <ast@kernel.org>
