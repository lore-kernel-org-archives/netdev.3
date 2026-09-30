Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637F31A38F9
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 02:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790736527; cv=none; b=XfPTNO+wdHixsL2FXCjqEXYHXRyKl0hoChxSIadY4zq3Ri20MJixO+pqxTYssm4jVuAMCNRKVmeHLung1YRH7V1HAOFc8jg1lF8jcuwdklZFOOSqulbMgZkD8GC+ZTOJkR65idMITAB74w4f/LcNZJ0y3G0SODpkSp6zLE5/q6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790736527; c=relaxed/simple;
	bh=28VJGaGYCOt9GHxPNIvpCUAJHTA56wpJDapQVToWmlE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=kg2qTCHQAjhKGF56iS4yLwiq/+ofGE3zNqXsfBxU35CjbY4rchC2quTYqT9tx5vs9auTuSsSHIASfIg+q7uw8KcOPgxAtEpN/AC9D0xfiMKwQJsKHcI/AjW4GaXT+EItXjSYyREED74k1qNf8SO7WPVksymMAxDsLyyc/uPFuwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgScvqiF; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgScvqiF"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e50968489so4294177d50.0
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 19:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790736525; x=1791341325; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rzAmP+8gP1YSHsfEOf23mQ5RQ2pqAIAvqO68/Lpegeo=;
        b=HgScvqiFNT0c4LeRHzBtA0z5qI65zst4U/uKGepcEAt7zjJC1cVEDWeD+63CxRMpzJ
         +R6HN67bd9ewbUv5ggK8KyDd08hyKdBEmaEC2W1IeyuHd3+vjyIP3/1ogOooASVO5dt2
         IN9pgtrkLejbWSR9qXgVcyKsbtCK/W7svx1Vvwjp4KQghRcuGIFwB69B0TCQ7ny/1lFd
         PckiXS3lRsMiUzfLoNZ+3b2z+BvLWJF9GeRSqlqNxvF3bwQqddFCH15vcSNyF52q5Dfg
         uebcae75H1IUZy5BqPMQuOCozFIxLSPMrkZyVn6Mp7lT/1iPXVQKyF8m9NK+wOFINE17
         9M6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790736525; x=1791341325;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rzAmP+8gP1YSHsfEOf23mQ5RQ2pqAIAvqO68/Lpegeo=;
        b=B5a8TF9Y0UZoUZeja9J2izoGTrXO6DRuniTeDWVWjoo+wdup/cOzXf5a+IwQOF5rf2
         4uEdpKmdNRTxBMMCErPYWyYJYXn+Ws8h0Yl+muLAIpQkQhlqa59ZbgIDrcx+BJYLbJY5
         s64P/TaNi/CGuNmLzjT2l3gGyaOduIFXF0p4J1ydjqaVrQUU/H4Vgx4h+l1V7vWkquim
         1zqH/oi8EA7qGd3rSu/pdFFWJhx40QkqgFYTeGozcEo8vmh7TMSCiw7uyzeBJcgnuvwX
         RjEUSFBIqql35hmpyTIVdK25apWaz7CjSq2I9FopPBb003F8lkfAKK5DmXX/woRPvq2+
         53+g==
X-Forwarded-Encrypted: i=1; AKwUvBznreFhHRJFTHqfVSyLK1Q2GhASVs12vammn0NNBqDLVzKy+PTUunnDo+LdEUOtQACKiNrTpQ8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKBWRIZV+qwZd3C+V4gzh/12EYEHP3JWl5uJM2LH2TkynnBUthm
	3TodAG575R9kI5FrXE66xWjn/tL2QAtulKluSBZft7FGR0fbzGrKGAR0
X-Gm-Gg: AYBFou2btptnIaIiu7yyeJJe9grYsrO5S6kA/o2+xqoT3YBjrV8DCBGjqBcn8M7+UVx
	+NQawzO5h8s1NIHDkXk7F5gLbBSqcW++ITDQ+X+1YzajnMXaok1IuHCQ3kXH+CdYFzlVjD9tsvS
	fe4+3mBpVBZQc47Q5Y+jtu/kBWf3ARHtr9YG/Lo3ojfET/o5fA/+c9nTU9IodnBa7jWhoAGQAi7
	JI8oBEgRfnlUpAZ90RsAySNg5Fub/qaqWQAl00Y8hSeoouvVXz5t+U2qJu30Pf4cjxcUrSggyXO
	kpK996gOLM6tPot6tzpiAJQ4pz/1as+KXLK6FETAcRGHlqHnSd73XUNc2/Q3+yUPrzJxM70APv+
	Nugn4jRZI/rI4qzwn7S/KZ3AHs0U1UHkUsUIDMTxhLAHD4Nu3GTnZ14RSVQeRz7E5oGOdvSxd1G
	cAQZuHoGBnz9oMKtVZyPh71ITggWXGzoUEF12PlEDZI026VJHTLE+E66KxV9k4Bgv+a8aih76sS
	+WoGvB/AMQacdpBMHdScgnucbW21DP8UDRIa4ym91nAbBtK2pAo
X-Received: by 2002:a05:690e:1c09:b0:675:5c5e:98e3 with SMTP id 956f58d0204a3-6768347dfaemr69016d50.41.1790736525346;
        Tue, 29 Sep 2026 19:48:45 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-676814d8e77sm179902d50.8.2026.09.29.19.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 19:48:44 -0700 (PDT)
Date: Tue, 29 Sep 2026 22:48:44 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Rongguang Wei <clementwei90@163.com>, 
 netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 jasowangio@gmail.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 Rongguang Wei <weirongguang@kylinos.cn>
Message-ID: <willemdebruijn.kernel.d4382759ce27@gmail.com>
In-Reply-To: <20260929093712.131096-5-clementwei90@163.com>
References: <20260929093712.131096-1-clementwei90@163.com>
 <20260929093712.131096-5-clementwei90@163.com>
Subject: Re: [PATCH v2 4/4] selftests: net: add TAP socket filter attach tests
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Rongguang Wei wrote:
> From: Rongguang Wei <weirongguang@kylinos.cn>
> 
> reattach_filter_without_user_buffer() attaches a filter, makes the buffer
> the program was copied from unreadable and then attaches the queue again,
> which used to fail with -EFAULT.
> 
> attach_filter_bad_len_keeps_descriptor() checks that a rejected
> TUNATTACHFILTER leaves both the saved descriptor and the installed filter
> alone.
> 
> attach_filter_nofilter_flag() and detach_filter_clears_reattach() cover the
> ways to attach a queue without a filter.
> 
> Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
  
> +/* accept: return skb->len */
> +static const struct sock_filter filter_accept[] = {
> +	BPF_STMT(BPF_LD | BPF_W | BPF_LEN, 0),
> +	BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 0),
> +	BPF_STMT(BPF_RET | BPF_A, 0),
> +};
> +
> +/* drop: return 0 */
> +static const struct sock_filter filter_drop[] = {
> +	BPF_STMT(BPF_RET | BPF_K, 0),
> +};

Are both programs needed? One will do, right?

> +static int tap_get_iff(int fd, short *flags)

nit: tun_get_iff? Or even tun_get_iff_flags.

Also, could just return flags if positive, no call-by-reference needed.

> +{
> +	struct ifreq ifr = { 0 };
> +
> +	if (ioctl(fd, TUNGETIFF, (void *)&ifr) < 0)
> +		return -1;
> +
> +	*flags = ifr.ifr_flags;
> +
> +	return 0;
> +}
> +

> +/* A new queue attached with IFF_NOFILTER must not get the filter that is
> + * configured on the device.
> + */
> +TEST_F(tun, attach_filter_nofilter_flag)
> +{
> +	struct ifreq ifr = { 0 };
> +	short flags = 0;
> +	int fd;
> +
> +	ASSERT_EQ(filter_attach(self->fd, filter_drop, ARRAY_SIZE(filter_drop)), 0);
> +
> +	fd = open("/dev/net/tun", O_RDWR);
> +	ASSERT_GE(fd, 0);
> +
> +	strcpy(ifr.ifr_name, self->ifname);
> +	ifr.ifr_flags = IFF_TAP | IFF_MULTI_QUEUE | IFF_NOFILTER;
> +	EXPECT_GE(ioctl(fd, TUNSETIFF, (void *)&ifr), 0);
> +
> +	EXPECT_EQ(tap_get_iff(fd, &flags), 0);
> +	EXPECT_NE(flags & IFF_NOFILTER, 0);

nit: here and elsewhere: avoid the double negative?

	EXPECT_EQ(flags & IFF_NOFILTER, IFF_NOFILTER)

> +/* A TUNATTACHFILTER with a bad length must not clobber the saved descriptor */

What is the descriptor in this context? Do you mean installed program?

> +TEST_F(tun, attach_filter_bad_len_keeps_descriptor)
> +{
> +	struct sock_fprog gf = { 0 };
> +	short flags = 0;
> +
> +	ASSERT_EQ(filter_attach(self->fd, filter_accept, ARRAY_SIZE(filter_accept)), 0);
> +
> +	errno = 0;
> +	EXPECT_EQ(filter_attach(self->fd, filter_accept, 0), -1);
> +	EXPECT_EQ(errno, EINVAL);
> +
> +	EXPECT_EQ(filter_get(self->fd, &gf), 0);
> +	EXPECT_EQ(gf.len, ARRAY_SIZE(filter_accept));
> +
> +	EXPECT_EQ(tap_get_iff(self->fd, &flags), 0);
> +	EXPECT_EQ(flags & IFF_NOFILTER, 0);
> +}
> +
>  FIXTURE(tun_vnet_udptnl)
>  {
>  	char ifname[IFNAMSIZ];
> -- 
> 2.25.1
> 
> 
> No virus found
> 		Checked by Hillstone Network AntiVirus
> 


