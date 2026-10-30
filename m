Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793353603;
	b=T2H6tmhCX5sXGY9NryMhG7tR5bgI3eAFeQqvSLj3unhu+5PjCOftGsSHamNX1zZ4ze/F
	 eVXn6LGivvbFgHosCFe2IC0wJmqLFjatE8Eu1/KkbOjq1cJOJslHS2Fjn0E3GA0SNOnD9
	 iqjMRjVjdNQczF6vGRRjysga7eF2hRaIc59Q1N1ZtvWzQwuwV+9wV/4hqkRS5/2E/HlM1
	 wBbJwmUDy+j64NXsea5yln+MSi4wWWkxpuQtRCwdoCD1YUAubWx+U9KksyXjdaa+tytRI
	 Bbmph1sFrn6lTCq/jcjVZyPi5RVWsSt1ztv2b9F+M9BeIdNOUDIk/njqmazXLD1xWSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793353603;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=IOz4ue54IuUUiPM1zk33V1FdxBfzHmxJTDRmhyQa7XU=;
	b=dMFEyh/mEDJO4JCrjzneHYJCtKvHaEjr4XQBf/pi+LKhPV5bz0sJieey979CI3jhOKBg
	 uzUGRCfbhVclzYG1tHtjQ9NepzDbLUshpeaV/s94XkWyjKRuk389J4PFD//5pV7xfbzr9
	 gvYbJZDfC9CEX8QYVtjKm3B7fmMqnPTA+Ue3fBCiXp9aH6aAWIs7kwATezjohtSdeSS0A
	 EFQVUd+JgeVWlEgwH3CJfp+WohulD5KKbuBdlgz+4eR8vfXmlK0YquoAGrA3kZnVXiNqv
	 gk+7QhN4jHAsFLWEvfAmjlURMxEjoJnmEgvI4l0QvkS3KgvLtvXv+asOGGV7iPByViQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0kQNarSx;
	arc=none smtp.remote-ip=74.125.227.130
Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9928606A31F
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 09:46:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9928606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0kQNarSx
Received: by mail-pj2-f2.google.com with SMTP id d9443c01a7336-2e651c30dcbso2873495ad.0
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 02:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793353602; x=1793958402; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IOz4ue54IuUUiPM1zk33V1FdxBfzHmxJTDRmhyQa7XU=;
        b=0kQNarSxZeE3Cgu1GV71IQdek42/dUZi3/owzf5Vhn4qSxRd1DyUIgfdlVEZ4HBb/C
         VYM32ZLAbj4dljoJS/GPhetwNEkkYloNNXA9XdW28TQUKhX4pJl2aOPcutJ2jPZWxPZJ
         mA6uT/BkIi0JbMbAHv7iJAMvQWG2CgRcaYFqne5jC4z/7mQcojmPslt2/MvEyFG43Sgv
         uWg7TF056NBGJI33kAGa0OSnk5APUaPUzs5z0ECZD5fukdrTttMeZCjrH5IQ1zNCrBjj
         B4R1XvC2/XOhfJiEEGil+7LysefNDT2yzXI9kEBdXd4K2FOw+x+AqPbqaPAPhvfMbWNl
         bN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793353602; x=1793958402;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IOz4ue54IuUUiPM1zk33V1FdxBfzHmxJTDRmhyQa7XU=;
        b=Cl63h7B5z4+N8jArP7vJ5y2NcKfWPSef7Wy47xIQ7/w24/GTXDpj7grhUQ8oh5U0E6
         ik4MwaMH240yJDX/1eXv3hBh8hnwoO8rdsm49jgEB7dpzXBs5jdyE39T1kMUDDlslfgm
         12BOf81+XNFtWmhNbeI7xBChf5Rpazks9uHcmC9EnYtYOc5it1AdbOKJLlSmwBrcivE1
         QA4KF+YmeONio9G5i04miOCfZish3Gy8oP/kJhZw3VzUnWz2uQ3u8I4OFb1miQM8PGNX
         ajr4BDQrPTCMppvXasom3nP2ijjiC8DC1bsdR9NJMmOryh1/uJQXUH6MbhMJGqfREYzA
         sLtw==
X-Gm-Message-State: AFq9FYKB1h2Z+8C22QJ0kK7cXd62Q4G9qbeF3lYmW/42g3953ZF7Tn1f
	5tNWCDHb/SkEGeRB1xK5zD1fz11Cre6mPhy3inaXlXw5uQarQfDc2H3x
X-Gm-Gg: AYBFou11FdGVM8ZS4HWTKURoKqVWCXBCbyLArbreu/ae78Cd0GCqJFxbX9awPXo1VRr
	NB6oaUpquRGOYBtZKF3uHarmu2HzVo6e2sFatkBnm2b34ZZDB4LX02Y/IUY4UnBW6HZw4d9US6l
	D3KR2w47nReoPg8lmUXAE7KI5eAIGb9BW1i1H+9FUhHrT4GYu2waGI5Es92+JPBL2owjblL05hu
	YapIE4CfsPSblrjtdG+feEMDyJhGel8KOb+hgzeXZJ/KQtFBUMH2jNhv5oelWBJBM1Qwk0zVfFe
	hRJeNRUTXmKwXTB9xg3RXZLuPwPbF9w15z7UZqaJQh583JMZyVEOGEaNos6kOet95LC22fyVPO1
	qXTqzlalNM0KRV7DaT+o8vj9Xd2ARd8uEzgptKMNJf1N/jbHI7bKETdxPKWLoyHHvqwiJ/bW2v+
	Hq2sj+0XWQg5JE/nC9Kt6tIgPcdyF0kTR0psE7WXIdNgr5RxriqXOhp9UivoIegb3sHxL6tMO43
	9aDGWLmQUQ0WF+ApI5oa7ZmgCZ8LLPM0Sfvl/L4vA/Xru4ssicfyx8fgSs0etC/hg6YFkVWcuGd
	DeMl5krVJzVl2jmx5mdx68QHMOfKQiAkc26b3YoC83KPFGsh2xqMm/XGbw/EGJM=
X-Received: by 2002:a17:902:ef03:b0:2e9:460e:ca49 with SMTP id d9443c01a7336-2eb3649be5bmr20449825ad.18.1793353602042;
        Fri, 30 Oct 2026 02:46:42 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:2600:2f3f:68c5:29e3:ffaa:7181])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb392aa7bcsm4998055ad.67.2026.10.30.02.46.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 Oct 2026 02:46:41 -0700 (PDT)
From: Rongzheng Wang <testwrzwrz@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: netdev@vger.kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	stable@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 1/2] xsk: defer software checksum until the skb is complete
Date: Fri, 30 Oct 2026 17:46:33 +0800
Message-Id: <20261030094633.27910-1-testwrzwrz@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <CAL+tcoBThTe7299eVU=tsUdi392dS9cioXX5RA5AKRsYAGbdVg@mail.gmail.com>
References: <20261030023248.78802-1-testwrzwrz@gmail.com> <20261030023248.78802-2-testwrzwrz@gmail.com> <CAL+tcoDUGqk-KfMBqdG4RBURHQc=9J+Ce7B7CZZWRN5yN7pRrw@mail.gmail.com> <20261030084017.16202-1-testwrzwrz@gmail.com> <CAL+tcoBThTe7299eVU=tsUdi392dS9cioXX5RA5AKRsYAGbdVg@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jason,

Makes sense, thanks. I'll wait for their feedback on the selftest patch
before sending v5, and fold it in together with the rest.

Thanks,
Rongzheng
